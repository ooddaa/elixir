defmodule Todo.Database.Worker do
  use GenServer

  # CLIENT
  def start_link(db_folder) do
    IO.puts("Starting database worker")
    GenServer.start_link(__MODULE__, db_folder)
  end

  def store(worker_pid, key, data) do
    GenServer.cast(worker_pid, {:store, key, data})
  end

  def get(worker_pid, key) do
    IO.puts("worker #{inspect worker_pid} gets to work")
    GenServer.call(worker_pid, {:get, key})
  end

  # SERVER
  @impl GenServer
  def init(db_folder) do
    {:ok, db_folder}
  end

  @impl GenServer
  def handle_cast({:store, key, data}, db_folder) do
    db_folder
      |> build_path(key)
      |> File.write!(:erlang.term_to_binary(data))

    {:noreply, db_folder}
  end

  @impl GenServer
  def handle_call({:get, key}, _caller, db_folder) do
    data =
      case File.read(build_path(db_folder, key)) do
        {:ok, contents} -> :erlang.binary_to_term(contents)
        _ -> nil
      end

    {:reply, data, db_folder}
  end

  def build_path(db_folder, key), do: Path.join(db_folder, to_string(key))
end
