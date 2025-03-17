defmodule QuantumRedlock.Application do
  @moduledoc false

  use Application

  @impl Application
  def start(_type, _args) do
    topologies = [
      quantum_redlock: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]

    children = [
      {
        Cluster.Supervisor,
        [topologies, [name: QuantumRedlock.ClusterSupervisor]]
      },
      {
        RedisMutex,
        name: QuantumRedlock.RedisMutex,
        host: Application.get_env(:quantum_redlock, :redis_host),
        port: Application.get_env(:quantum_redlock, :redis_port)
      },
      QuantumRedlock.Scheduler
    ]

    opts = [strategy: :one_for_one, name: QuantumRedlock.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
