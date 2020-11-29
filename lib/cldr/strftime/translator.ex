defmodule Cldr.Strftime.Translator do
  @moduledoc false

  @standard_formats [:short, :medium, :long, :full]

  def substitute(date_time_formats, date_formats, time_formats) do
    Enum.reduce @standard_formats, Map.new(), fn format, acc ->
      datetime_format = Map.fetch!(date_time_formats, format)
      date_format = Map.fetch!(date_formats, format)
      time_format = Map.fetch!(time_formats, format)

      parsed =
        datetime_format
        |> Cldr.Substitution.parse
        |> Enum.map(&translate/1)

      new_datetime_format =
        [time_format, date_format]
        |> Cldr.Substitution.substitute(parsed)
        |> Enum.join

      Map.put(acc, format, new_datetime_format)
    end
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

  def translate("'" <> rest) do
    quoted_string(rest)
  end

  def translate("%" <> rest) do
    "%%" <> translate(rest)
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
    "%4Y" <> translate(rest)
  end

  def translate("yy" <> rest) do
    "%2Y" <> translate(rest)
  end

  def translate("y" <> rest) do
    "%Y" <> translate(rest)
  end

  def translate("ZZZZ" <> rest) do
    "%Z" <> translate(rest)
  end

  def translate("ZZZ" <> rest) do
    "%Z" <> translate(rest)
  end

  def translate("ZZ" <> rest) do
    "%Z" <> translate(rest)
  end

  def translate("Z" <> rest) do
    "%Z" <> translate(rest)
  end

  def translate("zzzz" <> rest) do
    "%z" <> translate(rest)
  end

  def translate("zzz" <> rest) do
    "%z" <> translate(rest)
  end

  def translate("zz" <> rest) do
    "%z" <> translate(rest)
  end

  def translate("z" <> rest) do
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

  def translate(other) do
    other
  end

  defp quoted_string(string, acc \\ "")

  defp quoted_string("", acc) do
    acc
  end

  defp quoted_string("'" <> rest, acc) do
    acc <> rest
  end

  defp quoted_string(<< "\\", char :: utf8, rest :: binary >>, acc) do
    quoted_string(rest, << acc :: binary, char :: utf8 >>)
  end

  defp quoted_string(<< char :: utf8, rest :: binary >>, acc) do
    quoted_string(rest, << acc :: binary, char :: utf8 >>)
  end

end