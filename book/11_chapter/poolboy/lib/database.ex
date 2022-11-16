defmodule Todo.Database do
  @db_folder "./data"
  @pool_size 3

  # CLIENT
  def start_link do
    IO.puts("Starting supervised database workers")
    File.mkdir_p!(@db_folder)

    # prepare worker pool specification
    children = [:poolboy.child_spec({:worker, @db_folder}, poolboy_config())]

    # start worker pool supervised subtree
    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end

  defp poolboy_config do
    [
      name: {:local, :worker},
      worker_module: Todo.Database.Worker,
      size: 5,
      max_overflow: 2
    ]
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
    :poolboy.transaction(:worker, fn pid ->
      Todo.Database.Worker.store(pid, key, data)
    end)
  end

  def get(key) do
    :poolboy.transaction(:worker, fn pid ->
      Todo.Database.Worker.get(pid, key)
    end)
  end
end
