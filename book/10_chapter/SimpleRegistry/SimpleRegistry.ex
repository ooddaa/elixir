defmodule SimpleRegistry do
  use GenServer

  def start_link(), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  def init(_) do
    Process.flag(:trap_exit, true)
    {:ok, %{}}
  end

  def register(name), do: GenServer.call(__MODULE__, {:register, name})
  def whereis(name), do: GenServer.call(__MODULE__, {:whereis, name})
  def state, do: GenServer.call(__MODULE__, {:state})

  def handle_call({:register, name}, _from, state) do
    case Map.has_key?(state, name) do
      true -> {:reply, :error, state}
      false ->
        pid = case GenServer.start_link(__MODULE__, nil, name: name) do
          {:ok, pid} -> pid
          {:error, {:already_started, pid}} -> pid
        end
        new_state = Map.put(state, name, pid)
        {:reply, :ok, new_state}
    end
  end

  def handle_call({:whereis, name}, _from, state) do
    {:reply, Map.get(state, name, nil), state}
  end

  def handle_call({:state}, _from, state), do: {:reply, state, state}

  def handle_info(msg, state) do
    case msg do
      {:EXIT, pid, :killed} ->
        IO.puts("process #{inspect pid} exited, de-registering")
        new_state =
          state
          |> Enum.filter(fn { _, v } -> v !== pid end)
          |> Map.new()
        {:noreply, new_state}
      _ ->
        IO.puts("handle_info received msg: #{inspect msg}")
        {:noreply, state}
    end
  end

end
