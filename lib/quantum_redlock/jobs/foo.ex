defmodule QuantumRedlock.Jobs.Foo do
  @moduledoc false

  use QuantumRedlock.Job

  @impl QuantumRedlock.Job
  def run_mult_fn(_) do
    IO.inspect(Node.self(), label: "RUN MULT")

    :ok
  end

  @impl QuantumRedlock.Job
  def run_once_fn(_) do
    IO.puts("RUNNING ONCE STARTED")

    :rand.uniform(5) |> Kernel.*(1_000) |> :timer.sleep()

    IO.puts("RUNNING ONCE ENDED")

    :ok
  end
end
