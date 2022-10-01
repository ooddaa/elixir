defmodule Todo.Database do
  use GenServer
  @db_folder "./data"
  # CLIENT
  def start do
    GenServer.start(__MODULE__, nil)
  end

  def store(pid, key, data) do
    GenServer.cast(pid, {:store, key, data})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  # SERVER
  def init(_) do
    File.mkdir_p!(@db_folder)
    {:ok, nil}
  end

  def handle_cast({:store, key, data}, state) do
    key
      |> build_path()
      |> File.write!(:erlang.term_to_binary(data))

    {:noreply, state}
  end

  def handle_call({:get, key}, _from, state) do
    data = case File.read(build_path(key)) do
      {:ok, contents} -> :erlang.binary_to_term(contents)
      _ -> nil
    end

    {:reply, data, state}
  end

  def build_path(key) do
    # with absolute path
    # {:ok, cwd} = File.cwd()
    # cwd
    #   |> Path.split()
    #   |> Enum.reverse()
    #   |> then(&(["data/#{key}"|&1]))
    #   |> Enum.reverse()
    #   |> Path.join()

    # with relative path
    Path.join(@db_folder, to_string(key))
  end
end
