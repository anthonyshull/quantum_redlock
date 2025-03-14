defmodule QuantumRedlock.Application do
  @moduledoc false

  use Application

  @impl Application
  def start(_type, _args) do
    children = [
      QuantumRedlock.Scheduler,
      {
        RedisMutex,
        name: QuantumRedlock.RedisMutex,
        host: Application.get_env(:quantum_redlock, :redis_host),
        port: Application.get_env(:quantum_redlock, :redis_port)
      }
    ]

    opts = [strategy: :one_for_one, name: QuantumRedlock.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
