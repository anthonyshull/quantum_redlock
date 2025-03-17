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
      {:libcluster, "3.5.0"},
      {:quantum, "3.5.3"},
      {:quantum_storage_redis,
       git: "https://github.com/senconscious/quantum_storage_redis", branch: "main"},
      {:redis_mutex, "1.1.0"}
    ]
  end
end
