defmodule EchoServer do
  use GenServer

  def start_link(id) do
    GenServer.start_link(__MODULE__, nil, name: via_tuple(id))
  end

  def init(state), do: {:ok, state}

  def call(id, request) do
    GenServer.call(via_tuple(id), request)
  end

  defp via_tuple(id) do
    {:via, Registry, {:my_registry, { __MODULE__, id }}}
  end

  def handle_call(request, _from, state) do
    IO.puts("got: #{inspect request}")
    {:reply, request, state}
  end

end
