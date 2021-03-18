date = ~U[2019-08-26 13:52:06.0Z]

Benchee.run(
  %{
    "Cldr.DateTime.to_string" => fn ->
      Cldr.DateTime.to_string date
    end,
    "Cldr.Date.to_string" => fn ->
      Cldr.Date.to_string date
    end,
    "Calendar.strftime" => fn ->
      Calendar.strftime date, "%c", Cldr.Strftime.strftime_options!
    end,
  },
  time: 10,
  memory_time: 2
)