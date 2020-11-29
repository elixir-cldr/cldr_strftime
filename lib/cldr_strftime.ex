defmodule Cldr.Strftime do

  @doc false
  def cldr_backend_provider(config) do
    Cldr.Strftime.Backend.define_backend_modules(config)
  end

  @doc """
  Returns a keyword list of options than can be applied to
  `NimbleStrftime.format/3`.

  The hex package [nimble_strftime](https://hex.pm/packages/nimble_strftime)
  provides a `format/3` function to format dates, times and datetimes.
  It takes a set of options that can return day, month and am/pm names.

  `strftime_options!` returns a keyword list than can be used as these
  options to return localised names for days, months and am/pm.

  ## Arguments

  * `locale` is any locale returned by `MyApp.Cldr.known_locale_names/0`. The
    default is `MyApp.Cldr.get_locale/0`

  * `options` is a set of keyword options. The default is `[]`

  ## Options


  ## Example

      => MyApp.Cldr.Calendar.strftime_options!
      [
        am_pm_names: #Function<0.32021692/1 in MyApp.Cldr.Calendar.strftime_options/2>,
        month_names: #Function<1.32021692/1 in MyApp.Cldr.Calendar.strftime_options/2>,
        abbreviated_month_names: #Function<2.32021692/1 in MyApp.Cldr.Calendar.strftime_options/2>,
        day_of_week_names: #Function<3.32021692/1 in MyApp.Cldr.Calendar.strftime_options/2>,
        abbreviated_day_of_week_names: #Function<4.32021692/1 in MyApp.Cldr.Calendar.strftime_options/2>
      ]

  ## Typical usage from Elixir 1.11

      Calendar.strftime ~U[2019-08-26 13:52:06.0Z], "%B", Cldr.Strftime.strftime_options!
      => "August"

  """
  def strftime_options!(locale \\ Cldr.get_locale(), options \\ [])

  def strftime_options!(options, []) when is_list(options) do
    {locale, _backend} = Cldr.locale_and_backend_from(options)
    strftime_options!(locale, options)
  end

  def strftime_options!(locale, options) when is_list(options) do
    {locale, backend} = Cldr.locale_and_backend_from(locale, Keyword.get(options, :backend))

    with {:ok, locale} <- Cldr.validate_locale(locale, backend) do
      backend = Module.concat(locale.backend, Strftime)
      format = Keyword.get(options, :format, :medium)

      [
        am_pm_names: fn am_pm ->
          locale
          |> backend.day_periods()
          |> get_in([:format, :abbreviated, am_pm])
        end,
        month_names: fn month ->
          locale
          |> backend.months()
          |> get_in([:format, :wide, month])
        end,
        abbreviated_month_names: fn month ->
          locale
          |> backend.months()
          |> get_in([:format, :abbreviated, month])
        end,
        day_of_week_names: fn day ->
          locale
          |> backend.days()
          |> get_in([:format, :wide, day])
        end,
        abbreviated_day_of_week_names: fn day ->
          locale
          |> backend.days()
          |> get_in([:format, :abbreviated, day])
        end,
        preferred_date:
          locale
          |> backend.date_formats()
          |> unwrap_ok!
          |> Map.fetch!(format),
        preferred_time:
          locale
          |> backend.time_formats()
          |> unwrap_ok!
          |> Map.fetch!(format),
        preferred_datetime:
          locale
          |> backend.date_time_formats()
          |> unwrap_ok!
          |> Map.fetch!(format)
      ]
    else
      {:error, {exception, message}} -> raise exception, message
    end
  end

  defp unwrap_ok!({:ok, term}), do: term
  defp unwrap_ok!({:error, {exception, message}}), do: raise exception, message
end
