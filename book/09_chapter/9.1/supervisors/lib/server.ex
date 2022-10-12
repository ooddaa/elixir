defmodule Todo.Server do
  use GenServer

  # CLIENT
  def start_link(todo_list_name) do
    IO.puts("Starting to-do server for #{todo_list_name}.")
    GenServer.start_link(__MODULE__, todo_list_name)
  end

  def add_entry(todo_server, new_entry) do
    GenServer.cast(todo_server, {:add_entry, new_entry})
  end

  @doc """
  Shorten timeout
  """
  def entries(todo_server, date, timeout \\ 2500) do
    GenServer.call(todo_server, {:entries, date}, timeout)
  end

  # SERVER
  @impl GenServer
  def init(todo_list_name) do
    {:ok, {todo_list_name, Todo.Database.get(todo_list_name) || Todo.List.new()}}
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, { todo_list_name, todo_list }) do
    new_todolist = Todo.List.add_entry(todo_list, new_entry)
    Todo.Database.store(todo_list_name, new_todolist)
    {:noreply, { todo_list_name, new_todolist }}
  end

  @impl GenServer
  def handle_call({:entries, date}, _from, { todo_list_name, todo_list }) do
    {:reply, Todo.List.entries(todo_list, date), { todo_list_name, todo_list }}
  end
end

# %{date: ~D[2022-09-15], title: "go to park"}
