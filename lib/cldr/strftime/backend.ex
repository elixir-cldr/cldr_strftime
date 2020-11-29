defmodule Cldr.Strftime.Backend do
  @moduledoc false

  def define_backend_modules(config) do
    backend = config.backend
    config = Macro.escape(config)

    quote location: :keep, bind_quoted: [config: config, backend: backend] do
      defmodule Strftime do
        @moduledoc false
        if Cldr.Config.include_module_docs?(config.generate_docs) do
          @moduledoc """

          """
        end

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

        def eras(locale \\ Cldr.get_locale())

        def eras(%LanguageTag{cldr_locale_name: cldr_locale_name}) do
          eras(cldr_locale_name)
        end

        def quarters(locale \\ Cldr.get_locale())

        def quarters(%LanguageTag{cldr_locale_name: cldr_locale_name}) do
          quarters(cldr_locale_name)
        end

        def months(locale \\ Cldr.get_locale())

        def months(%LanguageTag{cldr_locale_name: cldr_locale_name}) do
          months(cldr_locale_name)
        end

        def days(locale \\ Cldr.get_locale())

        def days(%LanguageTag{cldr_locale_name: cldr_locale_name}) do
          days(cldr_locale_name)
        end

        def day_periods(locale \\ Cldr.get_locale())

        def day_periods(%LanguageTag{cldr_locale_name: cldr_locale_name}) do
          day_periods(cldr_locale_name)
        end

        for locale <- Cldr.Config.known_locale_names(config) do
          locale_data = Cldr.Config.get_locale(locale, config)
          calendar_data = get_in(locale_data, [:dates, :calendars, :gregorian])

          date_formats =
            calendar_data
            |> Map.fetch!(:date_formats)
            |> Cldr.Strftime.Translator.translate

          def date_formats(unquote(locale)) do
            {:ok, unquote(Macro.escape(date_formats))}
          end

          time_formats =
            calendar_data
            |> Map.fetch!(:time_formats)
            |> Cldr.Strftime.Translator.translate

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

          def eras(unquote(locale)) do
            unquote(Macro.escape(Map.get(calendar_data, :eras)))
          end

          def quarters(unquote(locale)) do
            unquote(Macro.escape(Map.get(calendar_data, :quarters)))
          end

          def months(unquote(locale)) do
            unquote(Macro.escape(Map.get(calendar_data, :months)))
          end

          def days(unquote(locale)) do
            unquote(Macro.escape(Map.get(calendar_data, :days)))
          end

          def day_periods(unquote(locale)) do
            unquote(Macro.escape(Map.get(calendar_data, :day_periods)))
          end
        end
      end

      def date_formats(locale), do: {:error, Cldr.Locale.locale_error(locale)}
      def time_formats(locale), do: {:error, Cldr.Locale.locale_error(locale)}
      def date_time_formats(locale), do: {:error, Cldr.Locale.locale_error(locale)}

      def quarters(locale), do: {:error, Cldr.Locale.locale_error(locale)}
      def months(locale), do: {:error, Cldr.Locale.locale_error(locale)}
      def days(locale), do: {:error, Cldr.Locale.locale_error(locale)}
      def day_periods(locale), do: {:error, Cldr.Locale.locale_error(locale)}

    end
  end
end