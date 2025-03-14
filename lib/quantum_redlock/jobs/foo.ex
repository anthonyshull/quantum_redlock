defmodule QuantumRedlock.Jobs.Foo do
  @moduledoc false

  use QuantumRedlock.Job

  @impl QuantumRedlock.Job
  def run_mult_fn(args) do
    IO.inspect(args, label: "RUN MULT")

    :ok
  end

  @impl QuantumRedlock.Job
  def run_once_fn(_) do
    IO.puts("RUNNING ONCE STARTED")

    :timer.sleep(3_000)

    IO.puts("RUNNING ONCE ENDED")

    :ok
  end
end
