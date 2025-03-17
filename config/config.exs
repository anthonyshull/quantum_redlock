import Config

config :logger, level: :info

config :quantum_redlock, QuantumRedlock.Scheduler,
  jobs: [
    run_mult: [
      schedule: "* * * * *",
      run_strategy: {Quantum.RunStrategy.All, :cluster},
      task: {QuantumRedlock.Jobs.Foo, :run_mult, [[]]}
    ],
    run_once: [
      schedule: "* * * * *",
      run_strategy: {Quantum.RunStrategy.Random, :cluster},
      task: {QuantumRedlock.Jobs.Foo, :run_once, [[]]}
    ]
  ]
