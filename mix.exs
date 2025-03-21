defmodule QuantumRedlock.MixProject do
  use Mix.Project

  def project do
    [
      app: :quantum_redlock,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {QuantumRedlock.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:quantum, "3.5.3"},
      {:redis_mutex, "1.1.0"}
    ]
  end
end
