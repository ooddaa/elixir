defmodule Todo.Database do
  use GenServer
  @db_folder "./data"

  # CLIENT
  def start_link(_) do
    IO.puts("Starting supervised database")
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def store(key, data) do
    GenServer.cast(choose_worker(key), {:store, key, data})
  end

  def get(key) do
    GenServer.call(choose_worker(key), {:get, key})
  end

  def choose_worker(key) do
    GenServer.call(__MODULE__, {:choose_worker, key})
  end

  # SERVER
  @impl true
  def init(_) do
    File.mkdir_p!(@db_folder)
    # worker pool
    {
      :ok,
      %{
        0 => Todo.Database.Worker.start_link(@db_folder),
        1 => Todo.Database.Worker.start_link(@db_folder),
        2 => Todo.Database.Worker.start_link(@db_folder),
      }
    }
  end

  @impl true
  def handle_call({:choose_worker, key}, _caller, worker_pool) do
    {:reply, Map.get(worker_pool, :erlang.phash2(key, 3)), worker_pool }
  end
end
