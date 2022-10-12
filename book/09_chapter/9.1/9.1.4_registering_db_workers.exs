# registration and discovery of todo database workers.
defmodule Todo.ProcessRegistry do
  def start_link do
    Registry.start_link(name: __MODULE__, keys: :unique)
  end

  def init(_), do: {:ok, nil}

  def via_tuple({module_name, id}) do
    {:via, Registry, {__MODULE__, {module_name, id}}}
  end
  # def via_tuple(key) do
  #   {:via, Registry, {__MODULE__, key}}
  # end

  def child_spec(_) do
    Supervisor.child_spec(
      Registry,
      id: __MODULE__,
      start: { __MODULE__, :start_link, [] }
    )
  end
end

defmodule EchoServer do
  use GenServer

  def start_link(id) do
    Todo.ProcessRegistry.start_link()
    GenServer.start_link(__MODULE__, nil, name: via_tuple(id))
  end

  def init(state) do
    {:ok, state}
  end

  def call(id, request) do
    GenServer.call(via_tuple(id), request)
  end

  defp via_tuple(id) do
    Todo.ProcessRegistry.via_tuple({ __MODULE__, id })
  end

  def handle_call(request, _from, state) do
    IO.puts("got: #{inspect request}")
    {:reply, request, state}
  end
end
