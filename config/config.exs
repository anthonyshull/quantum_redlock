import Config

config :quantum_redlock, QuantumRedlock.Scheduler,
  jobs: [
    run_mult: [
      schedule: "* * * * *",
      task: {QuantumRedlock.Jobs.Foo, :run_mult, [[]]}
    ],
    run_once: [
      schedule: "* * * * *",
      task: {QuantumRedlock.Jobs.Foo, :run_once, [[]]}
    ]
  ]
