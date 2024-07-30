defmodule MaycowMarket.MixProject do
  use Mix.Project

  def project do
    [
      app: :maycow_market,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [ignore_modules: [MaycowMarket.Product, MaycowMarket.Promotion]],
      # Docs
      name: "MaycowMarket",
      source_url: "https://github.com/maycowmeira/maycow_market",
      homepage_url: "https://github.com/maycowmeira/maycow_market",
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:decimal, "~> 2.0"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end
end
