defmodule Todo.Metrics do

  def start_link, do: Task.start_link(&loop/0)

  def child_spec(_) do
    %{
      id: __MODULE__, # set up id for multiple restarts in supervision tree
      start: {__MODULE__, :start_link, []},
      type: :supervisor,
    }
  end

  defp loop() do
    Process.sleep(:timer.seconds(5))
    collect_metrics()
    |> IO.inspect(label: "metrics")
    loop() # strangely I don't see any difference in behaviour w/wo the loop() ??
  end

  defp collect_metrics() do
    [
      memory_usage: :erlang.memory(:total), # https://www.erlang.org/doc/man/erlang.html#memory-1

      # System Limits
      process_count: :erlang.system_info(:process_count), # https://www.erlang.org/doc/man/erlang.html#system_info-1
      process_limit: :erlang.system_info(:process_limit),
      atom_count: :erlang.system_info(:atom_count),
      atom_limit: :erlang.system_info(:atom_limit),
      ets_count: :erlang.system_info(:ets_count),
      ets_limit: :erlang.system_info(:ets_limit),
      # CPU Topology
      cpu_topology: :erlang.system_info(:cpu_topology),
      logical_processors: :erlang.system_info(:logical_processors),
      update_cpu_info: :erlang.system_info(:update_cpu_info),

    ]
  end
end
