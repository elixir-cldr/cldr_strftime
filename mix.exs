defmodule Cldr.Strftime.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :ex_cldr_strftime,
      version: @version,
      name: "Cldr Strftime Options provider",
      source_url: "https://github.com/elixir-cldr/cldr_dstrftime",
      docs: docs(),
      elixir: "~> 1.8",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: Mix.compilers(),
      elixirc_paths: elixirc_paths(Mix.env()),
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore_warnings",
        plt_add_apps: ~w(calendar_interval)a
      ]
    ]
  end

  defp description do
    """
    Generates Calendar.strftime/3 options list
    from CLDR date time formats to support localised date, time
    and date time formatting.
    """
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def docs do
    [
      source_ref: "v#{@version}",
      main: "readme",
      extras: ["README.md", "CHANGELOG.md", "LICENSE.md"],
      logo: "logo.png",
      skip_undefined_reference_warnings_on: ["changelog", "readme", "CHANGELOG.md"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_cldr_numbers, "~> 2.16"},
      {:ex_cldr_calendars, "~> 1.11"},
      {:ex_cldr_dates_times, "~> 2.6"},
      {:calendar_interval, "~> 0.2", optional: true},
      {:ex_doc, "~> 0.18", runtime: false},
      {:jason, "~> 1.0", optional: true},
      {:benchee, "~> 1.0", optional: true, only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Kip Cole"],
      licenses: ["Apache 2.0"],
      links: links(),
      files: [
        "lib",
        "src/datetime_format_lexer.xrl",
        "config",
        "mix.exs",
        "README*",
        "CHANGELOG*",
        "LICENSE*"
      ]
    ]
  end

  def links do
    %{
      "GitHub" => "https://github.com/elixir-cldr/cldr_strftime",
      "Changelog" =>
        "https://github.com/elixir-cldr/cldr_strftime/blob/v#{@version}/CHANGELOG.md",
      "Readme" => "https://github.com/elixir-cldr/cldr_strftime/blob/v#{@version}/README.md"
    }
  end

  defp elixirc_paths(:test), do: ["lib", "mix", "test"]
  defp elixirc_paths(:dev), do: ["lib", "mix"]
  defp elixirc_paths(:docs), do: ["lib", "mix"]
  defp elixirc_paths(_), do: ["lib"]
end
