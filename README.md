# Calendar.strftime options generator for CLDR

[Calendar.strftime/2](https://hexdocs.pm/elixir/Calendar.html#strftime/3) has been available since Elixir 1.11 to provide date/datetime formatting using the principles that date back to at least [1978](https://en.wikipedia.org/wiki/The_C_Programming_Language).

The functions in this library are intended to serve options to `Calendar.strftime/3` to support localisation of dates/datetimes leveraging the content in [CLDR](https://cldr.unicode.org). Therefore a developer can take advantage of the built-in localised formats from `CLDR` with well-known `strftime` formatting strings.

### Installation

The package can be installed by adding `cldr_strftime` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_cldr_strftime, "~> 0.1.0"}
  ]
end
```

### Configuration

Update your `ex_cldr` backend module to include the provider module `Cldr.Strftime`. For example:

```elixir
defmodule MyApp.Cldr do
  use Cldr,
    locales: ["en", "fr", "af", "ja", "de", "pl", "th"],
    providers: [Cldr.Number, Cldr.Calendar, Cldr.DateTime, Cldr.Strftime]
end
```

Documentation is available at [https://hexdocs.pm/cldr_strftime](https://hexdocs.pm/cldr_strftime).

### Keyword Options returned

In accordance with the options defined for `Calendar.strftime/2`, `Cldr.Strftime.strftime_options!/2` returns the following keyword list:

* `:preferred_datetime` - a string for the preferred format to show datetimes,

* `:preferred_date` - a string for the preferred format to show dates.

* `:preferred_time` - a string for the preferred format to show times.

* `:am_pm_names` - a function that receives either :am or :pm and returns the name of the period of the day

* `:month_names` - a function that receives a number and returns the name of the corresponding month.

* `:abbreviated_month_names` - a function that receives a number and returns the abbreviated name of the corresponding month.

* `:day_of_week_names` - a function that receives a number and returns the name of the corresponding day of week.

* `:abbreviated_day_of_week_names` - a function that receives a number and returns the abbreviated name of the corresponding day of week

### CLDR format translation

[CLDR](https://cldr.unicode.org) [formats dates, times and date times](https://unicode.org/reports/tr35/tr35-dates.html#Contents) using a [different formatting system](https://unicode.org/reports/tr35/tr35-dates.html#Date_Field_Symbol_Table) to that of `Calendar.strftime/3`.  The CLDR formats are translated at compile time according to the following table. Since them formats are translated at compile time, performance is comparable to using native `Calendar.strftime/3`formats natively.

Strftime | CLDR     | Description                                                   | Examples (in ISO)
-------- | ---------| ------------------------------------------------------------- | ------------------
a        | E,EE,EEE | Abbreviated name of day                                       | Mon
A        | EEEE     | Full name of day                                              | Monday
b        | MMM      | Abbreviated month name                                        | Jan
B        | MMMM     | Full month name                                               | January
d        | d        | Day of the month                                              | 01, 12
H        | h        | Hour using a 24-hour clock                                    | 00, 23
I        | H        | Hour using a 12-hour clock                                    | 01, 12
j        | DDD      | Day of the year                                               | 001, 366
m        | MM       | Month                                                         | 01, 12
M        | mm       | Minute                                                        | 00, 59
p        | a,aa,aaa | "AM" or "PM" (noon is "PM", midnight as "AM")                 | AM, PM
q        | Q        | Quarter                                                       | 1, 2, 3, 4
S        | ss       | Second                                                        | 00, 59, 60
u        | s        | Day of the week                                               | 1 (Monday), 7 (Sunday)
y        | YY       | Year as 2-digits                                              | 01, 01, 86, 18
Y        | YYYY     | Year                                                          | -0001, 0001, 1986
z        | ZZZZ     | +hhmm/-hhmm time zone offset from UTC (empty string if naive) | +0300, -0530
Z        | V, VV    | Time zone abbreviation (empty string if naive)                | CET, BRST

[Calendar.strftime/3](https://hexdocs.pm/elixir/Calendar.html#strftime/3) allows for a set of options to guide formatting

### Example usage

These examples use the `%c`, `%x` and `%X` format flags which means "use the preferred_* option if provided".

```elixir
iex> Calendar.strftime ~U[2019-08-26 13:52:06.0Z], "%x", Cldr.Strftime.strftime_options!()
"Aug 26, 2019"

iex> Calendar.strftime ~U[2019-08-26 13:52:06.0Z], "%X", Cldr.Strftime.strftime_options!()
"13:52:06 PM"

iex> Calendar.strftime ~U[2019-08-26 13:52:06.0Z], "%c", Cldr.Strftime.strftime_options!()
"Aug 26, 2019, 13:52:06 PM"

iex> Calendar.strftime ~U[2019-08-26 13:52:06.0Z], "%c", Cldr.Strftime.strftime_options!("ja")
"2019/08/26 13:52:06"

iex> Calendar.strftime ~U[2019-08-26 13:52:06.0Z], "%c", Cldr.Strftime.strftime_options!("ja", format: :long)
"2019年08月26日 13:52:06 +0000"

iex> Calendar.strftime ~U[2019-08-26 13:52:06.0Z], "%c", Cldr.Strftime.strftime_options!("pl")
"26 sie 2019, 13:52:06"

iex> Calendar.strftime ~U[2019-08-26 13:52:06.0Z], "%c", Cldr.Strftime.strftime_options!("pl", format: :long)
"26 sierpnia 2019 13:52:06 +0000"
```

### Installation

The package can be installed by adding `cldr_strftime` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_cldr_strftime, "~> 0.1.0"}
  ]
end
```

### Configuration

Update your `ex_cldr` backend module to include the provider module `Cldr.Strftime`. For example:

```elixir
defmodule MyApp.Cldr do
  use Cldr,
    locales: ["en", "fr", "af", "ja", "de", "pl", "th"],
    providers: [Cldr.Number, Cldr.Calendar, Cldr.DateTime, Cldr.Strftime]
end
```

Documentation is available at [https://hexdocs.pm/cldr_strftime](https://hexdocs.pm/cldr_strftime).

