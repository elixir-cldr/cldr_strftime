defmodule Cldr.Strftime.Translator do

  @standard_formats [:short, :medium, :long, :full]

  def translate(formats) do
    Map.take(formats, @standard_formats)
  end

end