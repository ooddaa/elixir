defmodule KVS do
  use GenServer

  def init(_init_arg), do: {:ok, %{}}

  @impl true
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  # INTERFACE
  def start do
    {:ok, pid} = GenServer.start(__MODULE__, nil)
    IO.puts (inspect pid)
    case Process.whereis(:server) do
      nil -> Process.register(pid, :server)
      old_pid -> if is_pid(old_pid) do
        Process.unregister(:server)
        Process.register(pid, :server)
      end
    end
  end
  def put(key, value) do
    GenServer.cast(:server, {:put, key, value})
  end
  def get(key) do
    GenServer.call(:server, {:get, key})
  end
end
