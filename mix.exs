defmodule Ticketer.MixProject do
  use Mix.Project

  def project do
    [
      app: :ticketer,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: Ticketer]
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
      {:do_it, "~> 0.7"},
      {:req, "~> 0.5"}
    ]
  end
end
