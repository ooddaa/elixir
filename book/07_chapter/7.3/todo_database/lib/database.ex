defmodule Todo.Database do
  use GenServer
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
    {:ok, %{}}
  end

  def handle_cast({:store, key, data}, state) do
    binary = :erlang.term_to_binary(data)
    path = build_path(key)
    IO.inspect(path)
    :ok = File.write(path, binary)
    {:noreply, state}
  end

  def handle_call({:get, key}, _from, state) do
    path = build_path(key)
    IO.inspect(path)
    case File.read(path) do
      {:ok, binary} ->
        {:reply, :erlang.binary_to_term(binary), state}
      {:error, _} ->
        {:reple, {:error}, state}
    end
  end

  def build_path(key) do
    {:ok, cwd} = File.cwd()
      cwd
      |> Path.split()
      |> Enum.reverse()
      |> then(&(["data/#{key}"|&1]))
      |> Enum.reverse()
      |> Path.join()
  end
end
