defmodule Todo.Server do
  use GenServer

  # CLIENT
  def start do
    GenServer.start(__MODULE__, nil)
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
  @impl true
  def init(_) do
    {:ok, Todo.List.new()}
  end

  @impl true
  def handle_cast({:add_entry, new_entry}, todo_list) do
    {:noreply, Todo.List.add_entry(todo_list, new_entry)}
  end

  @impl true
  def handle_call({:entries, date}, _from, todo_list) do
    {:reply, Todo.List.entries(todo_list, date), todo_list}
  end
end
