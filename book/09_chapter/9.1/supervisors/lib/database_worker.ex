defmodule Todo.Database.Worker do
  use GenServer

  # CLIENT
  def start_link(db_folder) do
    IO.puts("starting database worker")
    {:ok, pid} = GenServer.start_link(__MODULE__, db_folder)
    pid
  end

  def store(key, data) do
    GenServer.cast(__MODULE__, {:store, key, data})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  # SERVER
  @impl true
  def init(db_folder) do
    File.mkdir_p!(db_folder)
    {:ok, db_folder}
  end

  @impl true
  def handle_cast({:store, key, data}, db_folder) do
    db_folder
      |> build_path(key)
      |> File.write!(:erlang.term_to_binary(data))

    {:noreply, db_folder}
  end

  @impl true
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
