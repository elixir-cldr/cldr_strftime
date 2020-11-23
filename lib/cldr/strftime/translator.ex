defmodule Cldr.Strftime.Translator do

  @standard_formats [:short, :medium, :long, :full]

  def translate(datetime_formats, _date_formats, _time_formats) do
    datetime_formats
  end

  def translate(formats) when is_map(formats) do
    formats
    |> Map.take(@standard_formats)
    |> Enum.map(fn {k, v} -> {k, translate(v)} end)
    |> Map.new
  end

  def translate("") do
    ""
  end

  def translate(<< "\\", char :: utf8, rest :: binary>>) do
    << "\\", char, translate(rest) :: binary >>
  end

  def translate("\"" <> rest) do
    quoted_string(rest)
  end

  def translate("EEEE" <> rest) do
    "%A" <> translate(rest)
  end

  def translate("EEE" <> rest) do
    "%a" <> translate(rest)
  end

  def translate("EE" <> rest) do
    "%a" <> translate(rest)
  end

  def translate("E" <> rest) do
    "%a" <> translate(rest)
  end

  def translate("MMMM" <> rest) do
    "%B" <> translate(rest)
  end

  def translate("MMM" <> rest) do
    "%b" <> translate(rest)
  end

  def translate("d" <> rest) do
    "%d" <> translate(rest)
  end

  def translate("h" <> rest) do
    "%H" <> translate(rest)
  end

  def translate("HH" <> rest) do
    "%H" <> translate(rest)
  end

  def translate("H" <> rest) do
    "%H" <> translate(rest)
  end

  def translate("DDD" <> rest) do
    "%j" <> translate(rest)
  end

  def translate("MM" <> rest) do
    "%m" <> translate(rest)
  end

  def translate("M" <> rest) do
    "%m" <> translate(rest)
  end

  def translate("mm" <> rest) do
    "%M" <> translate(rest)
  end

  def translate("aaa" <> rest) do
    "%p" <> translate(rest)
  end

  def translate("aa" <> rest) do
    "%p" <> translate(rest)
  end

  def translate("a" <> rest) do
    "%p" <> translate(rest)
  end

  def translate("Q" <> rest) do
    "%q" <> translate(rest)
  end

  def translate("ss" <> rest) do
    "%S" <> translate(rest)
  end

  def translate("s" <> rest) do
    "%u" <> translate(rest)
  end

  def translate("YYYY" <> rest) do
    "%Y" <> translate(rest)
  end

  def translate("YY" <> rest) do
    "%y" <> translate(rest)
  end

  def translate("yyyy" <> rest) do
    "%y" <> translate(rest)
  end

  def translate("yy" <> rest) do
    "%y" <> translate(rest)
  end

  def translate("y" <> rest) do
    "%y" <> translate(rest)
  end

  def translate("ZZZZ" <> rest) do
    "%z" <> translate(rest)
  end

  def translate("VV" <> rest) do
    "%Z" <> translate(rest)
  end

  def translate("V" <> rest) do
    "%Z" <> translate(rest)
  end

  def translate(<< char :: utf8, rest :: binary >>) do
    << char :: utf8, translate(rest) :: binary >>
  end

  defp quoted_string(string, acc \\ "")

  defp quoted_string("", acc) do
    acc
  end

  defp quoted_string("\"" <> rest, acc) do
    acc <> rest
  end

  defp quoted_string(<< "\\", char :: utf8, rest :: binary >>, acc) do
    quoted_string(rest, << char :: utf8, acc :: binary >>)
  end

  defp quoted_string(<< char :: utf8, rest :: binary >>, acc) do
    quoted_string(rest, << char :: utf8, acc :: binary >>)
  end

end