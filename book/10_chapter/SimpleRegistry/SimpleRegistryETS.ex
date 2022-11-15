defmodule SimpleRegistry do
  use GenServer

  def start_link, do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def register(name) do
    # I need to link a sapwned Agent process to main GenServer in order to
    # trap exits via handle_info
    {:ok, pid} = GenServer.call(__MODULE__, {:spawn})
    IO.inspect("registering #{inspect pid}")
    if :ets.insert_new(__MODULE__, { name, pid }) do
      :ok
    else
      :error
    end
  end

  def whereis(name) do
    case :ets.lookup(__MODULE__, name) do
      [{ ^name, pid }] -> pid
      [] -> nil
    end
  end

  def state, do: :ets.tab2list(__MODULE__) |> Map.new()

  @impl GenServer
  def init(_) do
    Process.flag(:trap_exit, true)
    :ets.new(__MODULE__, [:named_table, :public])
    {:ok, nil}
  end

  @impl GenServer
  def handle_call({:spawn}, _, state) do
    {:reply, Agent.start_link(fn -> %{} end), state}
  end

  @impl GenServer
  def handle_info(msg, state) do
    case msg do
      {:EXIT, pid, :killed} ->
        IO.puts("process #{inspect pid} was killed, de-registering")
        deregister(pid)
        {:noreply, state}

      {:EXIT, pid, :normal} ->
        IO.puts("process #{inspect pid} exited as normal, de-registering")
        deregister(pid)
        {:noreply, state}
      _ ->
        IO.puts("handle_info received msg: #{inspect msg}")
        {:noreply, state}
    end
  end

  defp deregister(pid) do
    :ets.match_delete(__MODULE__, { :_, pid })
  end

end

# defmodule SimpleRegistry do
#   use GenServer

#   def start_link, do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)
#   def register(name), do: GenServer.call(__MODULE__, {:register, name})
#   def whereis(name), do: GenServer.call(__MODULE__, {:whereis, name})
#   def state, do: GenServer.call(__MODULE__, {:state})

#   @impl GenServer
#   def init(_) do
#     Process.flag(:trap_exit, true)
#     :ets.new(__MODULE__, [:named_table, :public])
#     {:ok, nil}
#   end

#   @impl GenServer
#   def handle_call({:register, name}, _, state) do
#     case :ets.lookup(__MODULE__, name) do
#       [] ->
#         {:ok, pid} = Agent.start_link(fn -> %{} end)
#         IO.inspect("registering #{inspect pid}")
#         :ets.insert(__MODULE__, { name, pid })
#         {:reply, :ok, state}
#       _ ->  {:reply, :error, state}
#     end
#   end

#   @impl GenServer
#   def handle_call({:whereis, name}, _, state) do
#     pid = case :ets.lookup(__MODULE__, name) do
#       [{ ^name, pid }] -> pid
#       [] -> nil
#     end
#     {:reply, pid, state}
#   end

#   @impl GenServer
#   def handle_call({:state}, _, state) do
#     {:reply, :ets.tab2list(__MODULE__) |> Map.new(), state}
#   end

#   @impl GenServer
#   def handle_info(msg, state) do
#     case msg do
#       {:EXIT, pid, :killed} ->
#         IO.puts("process #{inspect pid} was killed, de-registering")
#         deregister(pid)
#         {:noreply, state}

#       {:EXIT, pid, :normal} ->
#         IO.puts("process #{inspect pid} exited as normal, de-registering")
#         deregister(pid)
#         {:noreply, state}
#       _ ->
#         IO.puts("handle_info received msg: #{inspect msg}")
#         {:noreply, state}
#     end
#   end

#   defp deregister(pid) do
#     :ets.match_delete(__MODULE__, { :_, pid })
#   end

# end
