defmodule SimpleRegistry do
  use GenServer

  def start_link, do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  def register(name), do: GenServer.call(__MODULE__, {:register, name})
  def whereis(name), do: GenServer.call(__MODULE__, {:whereis, name})
  def state, do: GenServer.call(__MODULE__, {:state})

  @impl GenServer
  def init(_) do
    Process.flag(:trap_exit, true)
    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:register, name}, _, state) do
    case Map.has_key?(state, name) do
      true -> {:reply, :error, state}
      false ->
        {:ok, pid} = Agent.start_link(fn -> %{} end)
        IO.inspect("registering #{inspect pid}")
        {:reply, :ok, Map.put(state, name, pid)}
    end
  end

  @impl GenServer
  def handle_call({:whereis, name}, _, state) do
    {:reply, Map.get(state, name), state}
  end

  @impl GenServer
  def handle_call({:state}, _, state), do: {:reply, state, state}

  @impl GenServer
  def handle_info(msg, state) do
    case msg do
      {:EXIT, pid, :killed} ->
        IO.puts("process #{inspect pid} was killed, de-registering")
        {:noreply, deregister(pid, state)}

      {:EXIT, pid, :normal} ->
        IO.puts("process #{inspect pid} exited as normal, de-registering")
        {:noreply, deregister(pid, state)}
      _ ->
        IO.puts("handle_info received msg: #{inspect msg}")
        {:noreply, state}
    end
  end

  defp deregister(pid, state) do
    state
      |> Enum.filter(fn { _, v } -> v !== pid end)
      |> Map.new()
  end

end
