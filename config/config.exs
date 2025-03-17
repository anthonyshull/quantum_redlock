import Config

config :logger, level: :info

config :quantum_redlock, QuantumRedlock.Scheduler,
  jobs: [
    run_mult: [
      run_strategy: Quantum.RunStrategy.Local,
      schedule: {:extended, "*/15"},
      task: {QuantumRedlock.Jobs.Foo, :run_mult, [nil]}
    ],
    run_once_a: [
      run_strategy: {Quantum.RunStrategy.Random, :cluster},
      schedule: {:extended, "*/15"},
      task: {QuantumRedlock.Jobs.Foo, :run_once, ["a"]}
    ],
    run_once_b: [
      run_strategy: {Quantum.RunStrategy.Random, :cluster},
      schedule: {:extended, "*/15"},
      task: {QuantumRedlock.Jobs.Foo, :run_once, ["b"]}
    ]
  ]
