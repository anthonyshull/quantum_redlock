import Config

config :quantum_redlock, QuantumRedlock.Scheduler,
  jobs: [
    run_mult: [
      schedule: "@reboot",
      task: {QuantumRedlock.Jobs.Foo, :run_mult, [[]]}
    ],
    run_once: [
      schedule: {:extended, "*/5 * * * * *"},
      task: {QuantumRedlock.Jobs.Foo, :run_once, [[]]}
    ]
  ]
