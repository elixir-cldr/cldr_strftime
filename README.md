# Calendar.strftime options generator for CLDR

[Calendar.strftime/2](https://hexdocs.pm/elixir/Calendar.html#strftime/3) has been available since Elixir 1.11 to provide date/datetime formatting using the principles that date back to at least [1978](https://en.wikipedia.org/wiki/The_C_Programming_Language).

The functions in this library are intended to serve options to `Calendar.strftime/3` to support localisation of dates/datetimes leveraging the content in [CLDR](https://cldr.unicode.org).

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
P        | a,aa,aaa | "am" or "pm" (noon is "pm", midnight as "am")                 | am, pm
q        | Q        | Quarter                                                       | 1, 2, 3, 4
S        | ss       | Second                                                        | 00, 59, 60
u        | s        | Day of the week                                               | 1 (Monday), 7 (Sunday)
y        | YY       | Year as 2-digits                                              | 01, 01, 86, 18
Y        | YYYY     | Year                                                          | -0001, 0001, 1986
z        | ZZZZ     | +hhmm/-hhmm time zone offset from UTC (empty string if naive) | +0300, -0530
Z        | V, VV    | Time zone abbreviation (empty string if naive)                | CET, BRST

[Calendar.strftime/3](https://hexdocs.pm/elixir/Calendar.html#strftime/3) allows for a set of options to guide formatting
#### Options

  • :preferred_datetime - a string for the preferred format to show
    datetimes, it can't contain the %c format and defaults to "%Y-%m-%d
    %H:%M:%S" if the option is not received
  • :preferred_date - a string for the preferred format to show dates, it
    can't contain the %x format and defaults to "%Y-%m-%d" if the option is not
    received
  • :preferred_time - a string for the preferred format to show times, it
    can't contain the %X format and defaults to "%H:%M:%S" if the option is not
    received
  • :am_pm_names - a function that receives either :am or :pm and returns
    the name of the period of the day, if the option is not received it
    defaults to a function that returns "am" and "pm", respectively
  •  :month_names - a function that receives a number and returns the name
    of the corresponding month, if the option is not received it defaults to a
    function that returns the month names in English
  • :abbreviated_month_names - a function that receives a number and
    returns the abbreviated name of the corresponding month, if the option is
    not received it defaults to a function that returns the abbreviated month
    names in English
  • :day_of_week_names - a function that receives a number and returns the
    name of the corresponding day of week, if the option is not received it
    defaults to a function that returns the day of week names in English
  • :abbreviated_day_of_week_names - a function that receives a number and
    returns the abbreviated name of the corresponding day of week, if the
    option is not received it defaults to a function that returns the
    abbreviated day of week names in English

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cldr_strftime` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cldr_strftime, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/cldr_strftime](https://hexdocs.pm/cldr_strftime).

