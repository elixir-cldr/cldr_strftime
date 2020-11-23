require Cldr.Strftime

defmodule MyApp.Cldr do
  use Cldr,
    locales: ["en", "fr", "af", "ja", "de", "pl", "th"],
    providers: [Cldr.Number, Cldr.Calendar, Cldr.DateTime, Cldr.Strftime]
end