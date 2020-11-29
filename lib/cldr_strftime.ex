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

  * `locale` is any locale returned by `Cldr.known_locale_names/1`. The
    default is `Cldr.get_locale/0`

  * `options` is a set of keyword options. The default is `[]`

  ## Options

  * `:format` determines the format of the date, time or
    date time. The options are `:short`, `:medium`, `:long`
    and `:full`. The default is `:medium`.

  ## Example

      => Cldr.Strftime.strftime_options!
      [
        am_pm_names: #Function<0.117825700/1 in MyApp.Cldr.Calendar.strftime_options!/2>,
        month_names: #Function<1.117825700/1 in MyApp.Cldr.Calendar.strftime_options!/2>,
        abbreviated_month_names: #Function<2.117825700/1 in MyApp.Cldr.Calendar.strftime_options!/2>,
        day_of_week_names: #Function<3.117825700/1 in MyApp.Cldr.Calendar.strftime_options!/2>,
        abbreviated_day_of_week_names: #Function<4.117825700/1 in MyApp.Cldr.Calendar.strftime_options!/2>,
        preferred_date: "%b %d, %Y",
        preferred_time: "%H:%M:%S %p",
        preferred_datetime: "%b %d, %Y, %H:%M:%S %p"
      ]

  ## Typical usage from Elixir 1.11

      iex> Calendar.strftime ~U[2019-08-26 13:52:06.0Z], "%x", Cldr.Strftime.strftime_options!
      "Aug 26, 2019"

      iex> Calendar.strftime ~U[2019-08-26 13:52:06.0Z], "%X", Cldr.Strftime.strftime_options!
      "13:52:06 PM"

      iex> Calendar.strftime ~U[2019-08-26 13:52:06.0Z], "%c", Cldr.Strftime.strftime_options!
      "Aug 26, 2019, 13:52:06 PM"

  """
  def strftime_options!(locale \\ Cldr.get_locale(), options \\ [])

  def strftime_options!(options, []) when is_list(options) do
    {locale, _backend} = Cldr.locale_and_backend_from(options)
    strftime_options!(locale, options)
  end

  def strftime_options!(locale, options) when is_list(options) do
    {locale, backend} = Cldr.locale_and_backend_from(locale, Keyword.get(options, :backend))

    with {:ok, locale} <- Cldr.validate_locale(locale, backend) do
      calendar_backend = Module.concat(locale.backend, Calendar)
      strftime_backend = Module.concat(locale.backend, Strftime)
      format = Keyword.get(options, :format, :medium)

      locale
      |> calendar_backend.strftime_options!(options)
      |> Keyword.merge(preferred_formats(locale, format, strftime_backend))
    else
      {:error, {exception, message}} -> raise exception, message
    end
  end

  def preferred_formats(locale, format, strftime_backend) do
    [
      preferred_date:
        locale
        |> strftime_backend.date_formats()
        |> unwrap_ok!
        |> Map.fetch!(format),
      preferred_time:
        locale
        |> strftime_backend.time_formats()
        |> unwrap_ok!
        |> Map.fetch!(format),
      preferred_datetime:
        locale
        |> strftime_backend.date_time_formats()
        |> unwrap_ok!
        |> Map.fetch!(format)
    ]
  end

  defp unwrap_ok!({:ok, term}), do: term
  defp unwrap_ok!({:error, {exception, message}}), do: raise exception, message
end
