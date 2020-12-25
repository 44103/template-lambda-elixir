defmodule LambdaEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :lambda_ex,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:mix_erllambda, "~> 1.0"},
      {:erllambda, "~> 2.0"},
      {:jiffy, "~> 1.0"},
      {:jason, "~> 1.2"},
      {:httpoison, "~> 0.13"}
    ]
  end
end
