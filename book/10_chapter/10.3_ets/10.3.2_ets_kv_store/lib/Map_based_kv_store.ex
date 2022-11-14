defmodule :mkv do
  use GenServer

  def start_link, do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  def init(_), do: { :ok, %{} }

  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def handle_cast({:put, key, value}, current_store) do
    {:noreply, Map.put(current_store, key, value)}
  end

  def handle_call({:get, key}, _from, current_store) do
    {:reply, Map.get(current_store, key), current_store}
  end
end

# mix run -e "Bench.run(:mkv)"
# 532_748 operations/sec

# mix run -e "Bench.run(:mkv, concurrency: 1000)"
# 551_944 operations/sec
