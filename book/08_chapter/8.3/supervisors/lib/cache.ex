# the process will provide to-do server pids.
# You give it a name, and it gives you the corresponding pro- cess.
defmodule Todo.Cache do
  use GenServer

  # CLIENT
  def start_link(_) do
    IO.puts("Starting todo cache")
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def server_process(todo_list_name) do
    GenServer.call(__MODULE__, {:server_process, todo_list_name})
  end

  def break do
    raise("kill!")
  end

  # SERVER
  def init(_init_state) do
    {:ok, %{}}
  end

  def handle_call({:get_pid, name}, _from, state) do
    {:reply, Map.get(state, name), state}
  end

  def handle_call({:server_process, todo_list_name}, _from, todo_servers) do
    case Map.fetch(todo_servers, todo_list_name) do
      {:ok, todo_server} ->
        {:reply, todo_server, todo_servers}

      :error ->
        {:ok, new_server} = Todo.Server.start(todo_list_name)

        {
          :reply,
          new_server,
          Map.put(todo_servers, todo_list_name, new_server)
        }
    end
  end

  def handle_cast({:get_pid, name}, state) do
    {:noreply, Map.get(state, name), state}
  end
end
