import Config

redis_host = System.get_env("REDIS_HOST", "127.0.0.1")
redis_port = System.get_env("REDIS_PORT", "6379") |> String.to_integer()

config :quantum_redlock, [
  redis_host: redis_host,
  redis_port: redis_port
]

config :quantum_redlock, QuantumRedlock.Scheduler,
  storage: QuantumStorageRedis,
  storage_opts: [name: QuantumRedlock.Storage, host: redis_host, port: redis_port]
