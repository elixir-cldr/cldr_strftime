defmodule Cldr.Strftime.Backend do
  @moduledoc false

  def define_backend_modules(config) do
    backend = config.backend
    config = Macro.escape(config)

    quote location: :keep, bind_quoted: [config: config, backend: backend] do
      defmodule Strftime do
        @moduledoc false

        alias Cldr.Calendar
        alias Cldr.LanguageTag

        def date_formats(locale \\ Cldr.get_locale())

        def date_formats(%LanguageTag{cldr_locale_name: cldr_locale_name}) do
          date_formats(cldr_locale_name)
        end

        def time_formats(locale \\ Cldr.get_locale())

        def time_formats(%LanguageTag{cldr_locale_name: cldr_locale_name}) do
          time_formats(cldr_locale_name)
        end

        def date_time_formats(locale \\ Cldr.get_locale())

        def date_time_formats(%LanguageTag{cldr_locale_name: cldr_locale_name}) do
          date_time_formats(cldr_locale_name)
        end

        for locale <- Cldr.Locale.Loader.known_locale_names(config) do
          locale_data = Cldr.Locale.Loader.get_locale(locale, config)
          calendar_data = get_in(locale_data, [:dates, :calendars, :gregorian])

          date_formats =
            calendar_data
            |> Map.fetch!(:date_formats)
            |> Cldr.Strftime.Translator.translate()

          def date_formats(unquote(locale)) do
            {:ok, unquote(Macro.escape(date_formats))}
          end

          time_formats =
            calendar_data
            |> Map.fetch!(:time_formats)
            |> Cldr.Strftime.Translator.translate()

          def time_formats(unquote(locale)) do
            {:ok, unquote(Macro.escape(time_formats))}
          end

          date_time_formats =
            calendar_data
            |> Map.fetch!(:date_time_formats)
            |> Cldr.Strftime.Translator.substitute(date_formats, time_formats)

          def date_time_formats(unquote(locale)) do
            {:ok, unquote(Macro.escape(date_time_formats))}
          end
        end
      end

      def date_formats(locale), do: {:error, Cldr.Locale.locale_error(locale)}
      def time_formats(locale), do: {:error, Cldr.Locale.locale_error(locale)}
      def date_time_formats(locale), do: {:error, Cldr.Locale.locale_error(locale)}
    end
  end
end
