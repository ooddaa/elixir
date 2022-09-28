defmodule KVS do
  use GenServer

  @impl true
  def init(_init_arg) do
    :timer.send_interval(2_000, :cleanup)
    :timer.send_after(:timer.seconds(5), :headsup)
    {:ok, %{}}
  end

  @impl true
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  @impl true
  def handle_info(:cleanup, state) do
    IO.puts "cleaning up"
    {:noreply, state}
  end

  @impl true
  def handle_info(:headsup, state) do
    IO.puts "everything is great 👍"
    :timer.send_after(:timer.seconds(3), :headsup)
    {:noreply, state}
  end

  # INTERFACE
  def start do
    {:ok, pid} = GenServer.start(__MODULE__, nil, name: __MODULE__)
    IO.puts (inspect pid)
  end

  def stop do
    GenServer.stop(__MODULE__, :normal)
  end

  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end
end

# defmodule KVS do
#   use GenServer

#   @impl true
#   def init(_init_arg) do
#     :timer.send_interval(2_000, :cleanup)
#     :timer.send_after(:timer.seconds(5), :headsup)
#     {:ok, %{}}
#   end

#   @impl true
#   def handle_cast({:put, key, value}, state) do
#     {:noreply, Map.put(state, key, value)}
#   end

#   @impl true
#   def handle_call({:get, key}, _from, state) do
#     {:reply, Map.get(state, key), state}
#   end

#   @impl true
#   def handle_info(:cleanup, state) do
#     IO.puts "cleaning up"
#     {:noreply, state}
#   end

#   @impl true
#   def handle_info(:headsup, state) do
#     IO.puts "everything is great 👍"
#     :timer.send_after(:timer.seconds(3), :headsup)
#     {:noreply, state}
#   end

#   # INTERFACE
#   def start do
#     {:ok, pid} = GenServer.start(__MODULE__, nil)
#     IO.puts (inspect pid)
#     case Process.whereis(:server) do
#       nil -> Process.register(pid, :server)
#       old_pid -> if is_pid(old_pid) do
#         Process.unregister(:server)
#         Process.register(pid, :server)
#       end
#     end
#     {:ok, pid}
#   end

#   def put(key, value) do
#     GenServer.cast(:server, {:put, key, value})
#   end

#   def get(key) do
#     GenServer.call(:server, {:get, key})
#   end
# end

ExUnit.start()

defmodule KVS.Test do
  use ExUnit.Case, async: true

  setup do
    KVS.start
    %{}
  end

  test "puts and gets" do
    assert KVS.get(:a) == nil
    assert KVS.put(:a, 1) == :ok
    assert KVS.get(:a) == 1
  end

end
