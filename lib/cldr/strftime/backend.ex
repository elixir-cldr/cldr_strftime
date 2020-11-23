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
            |> Cldr.Strftime.Translator.translate(date_formats, time_formats)

          def date_time_formats(unquote(locale)) do
            {:ok, unquote(Macro.escape(date_time_formats))}
          end
        end
      end
    end
  end
end