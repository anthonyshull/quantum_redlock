defmodule QuantumRedlock.Job do
  @moduledoc false

  @callback run_mult_fn(args :: [any()]) :: :ok | {:error, term}
  @callback run_once_fn(args :: [any()]) :: :ok | {:error, term}

  @optional_callbacks run_mult_fn: 1, run_once_fn: 1

  defmacro __using__(_) do
    quote do
      require Logger

      @behaviour QuantumRedlock.Job

      @mutex_options [name: QuantumRedlock.RedisMutex, timeout: 500, expiry: 15_000]
      @not_implemented_error "This function is not implemented"

      def run_mult_fn(args), do: {:error, @not_implemented_error}
      def run_once_fn(args), do: {:error, @not_implemented_error}

      defoverridable run_mult_fn: 1, run_once_fn: 1

      def run_mult(args), do: run_mult_fn(args)

      def run_once(args) do
        try do
          RedisMutex.with_lock(
            key(),
            fn -> run_once_fn(args) end,
            @mutex_options
          )
        rescue e in [RedisMutex.Error] ->
          Logger.warning("#{__MODULE__}: could not obtain lock")

          {:error, e}
        end
      end

      defp key() do
        __MODULE__
        |> Module.split()
        |> Kernel.tl()
        |> Enum.join(".")
        |> :erlang.phash2()
        |> Integer.to_string()
      end
    end
  end
end
