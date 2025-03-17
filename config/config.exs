import Config

config :logger, level: :info

config :quantum_redlock, QuantumRedlock.Scheduler,
  jobs: [
    run_once_a: [
      schedule: {:extended, "*/5"},
      task: {QuantumRedlock.Jobs.Foo, :run_once, ["a"]}
    ],
    run_once_b: [
      schedule: {:extended, "*/5"},
      task: {QuantumRedlock.Jobs.Foo, :run_once, ["b"]}
    ]
  ]
