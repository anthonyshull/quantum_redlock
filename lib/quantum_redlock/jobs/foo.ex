defmodule QuantumRedlock.Jobs.Foo do
  @moduledoc false

  require Logger

  use QuantumRedlock.Job

  @impl QuantumRedlock.Job
  def run_mult_fn(_) do
    Logger.info("RUN MULT")

    :ok
  end

  @impl QuantumRedlock.Job
  def run_once_fn(_) do
    Logger.info("RUN ONCE")

    :ok
  end
end
