defmodule Todo.Database do
  @db_folder "./data"
  @pool_size 3

  # CLIENT
  def start_link do
    IO.puts("Starting supervised database workers")
    File.mkdir_p!(@db_folder)

    # prepare worker pool specification
    children = Enum.map(1..@pool_size, &worker_spec/1)

    # start worker pool supervised subtree
    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end

  defp worker_spec(worker_id) do
    # https://hexdocs.pm/elixir/Supervisor.html#module-child-specification
    # a tuple with a module as first element and the start argument as second - such as {Counter, 0}. In this case, Counter.child_spec(0) is called to retrieve the child specification

    default_worker_spec = {Todo.Database.Worker, {@db_folder, worker_id}}
    # # If a two-element tuple in the shape of {module, arg} is given,
    # # the child specification is retrieved by calling module.
    # # child_spec(arg).
    Supervisor.child_spec(default_worker_spec, id: worker_id)

    ## SAME AS
    # %{
    #   id: worker_id,
    #   start: {Todo.Database.Worker, :start_link, [{@db_folder, worker_id}]},
    # }
  end

  ## if Todo.Database is given as child a Supervisor as "Todo.Database", this will be called
  def child_spec(_) do
    %{
      id: __MODULE__, # set up id for multiple restarts in supervision tree
      start: {__MODULE__, :start_link, []},
      type: :supervisor,
    }
  end

  ## this won't work - circular call to Todo.Database ?
  # def child_spec(_) do
  #   Supervisor.child_spec(
  #     # __MODULE__,
  #     Todo.Database,
  #     id: __MODULE__,
  #     start: { __MODULE__, :start_link, [] },
  #     type: :supervisor
  #   )
  # end

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
