defmodule Todo.Database do
  use GenServer
  @db_folder "./data"

  # CLIENT
  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def store(key, data) do
    GenServer.cast(__MODULE__, {:store, key, data})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  # SERVER
  @impl true
  def init(_) do
    File.mkdir_p!(@db_folder)
    {:ok, nil}
  end

  @impl true
  def handle_cast({:store, key, data}, state) do
    # run a separate worker
    spawn(fn ->
      key
        |> build_path()
        |> File.write!(:erlang.term_to_binary(data))
    end)

    {:noreply, state}
  end

  @impl true
  def handle_call({:get, key}, caller, state) do
    # run a separate worker
    spawn(fn ->
      data = case File.read(build_path(key)) do
        {:ok, contents} -> :erlang.binary_to_term(contents)
        _ -> nil
      end

      GenServer.reply(caller, data)
    end)

    {:noreply, state}
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
