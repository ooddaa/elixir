defmodule Todo.Database do
  @db_folder "./data"
  @pool_size 3

  # CLIENT
  def start_link do
    IO.puts("Starting supervised database workers")
    File.mkdir_p!(@db_folder)

    children = Enum.map(1..@pool_size, &worker_spec/1)
    # IO.inspect(children)
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  defp worker_spec(worker_id) do
    # https://hexdocs.pm/elixir/Supervisor.html#module-child-specification
    # a tuple with a module as first element and the start argument as second - such as {Counter, 0}. In this case, Counter.child_spec(0) is called to retrieve the child specification
    default_worker_spec = {Todo.Database.Worker, {@db_folder, worker_id}}
    Supervisor.child_spec(default_worker_spec, id: worker_id)
  end

  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :supervisor,
    }
  end

  def store(key, data) do
    key
    |> choose_worker()
    |> Todo.Database.Worker.store(key, data)

  end

  def get(key) do
    key
    |> choose_worker()
    |> Todo.Database.Worker.get(key)
  end

  defp choose_worker(key) do
    :erlang.phash2(key, @pool_size) + 1
  end
end
