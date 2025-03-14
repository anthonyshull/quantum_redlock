import Config

config :quantum_redlock, [
  redis_host: System.get_env("REDIS_HOST", "127.0.0.1"),
  redis_port: System.get_env("REDIS_PORT", "6379") |> String.to_integer()
]
