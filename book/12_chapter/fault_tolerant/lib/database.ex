defmodule Todo.Database do
  @spec child_spec(any) :: none
  def child_spec(_) do
    db_settings = Application.fetch_env!(:todo, :database)

    # Node name is used to determine the database folder. This allows us to
    # start multiple nodes from the same folders, and data will not clash.
    [name_prefix, _] = "#{node()}" |> String.split("@")
    db_folder = "#{Keyword.fetch!(db_settings, :folder)}/#{name_prefix}/"

    File.mkdir_p!(db_folder)

    :poolboy.child_spec(
      __MODULE__,
      [
        name: {:local, __MODULE__},
        worker_module: Todo.Database.Worker,
        size: Keyword.fetch!(db_settings, :pool_size)
      ],
      [db_folder]
    )
  end

  @spec store(any, any) :: :ok
  def store(key, data) do
    {results, bad_nodes} =
      :rpc.multicall(
        __MODULE__,
        :store_local,
        [key, data],
        :timer.seconds(5)
      )

    Enum.each(results, &IO.puts("Stored on node #{inspect &1}"))
    Enum.each(bad_nodes, &IO.puts("Store failed on node #{&1}"))
    :ok
  end

  @spec store_local(any, any) :: any
  def store_local(key, data) do
    :poolboy.transaction(__MODULE__, fn worker_pid ->
      Todo.Database.Worker.store(worker_pid, key, data)
    end)
  end

  @spec get(any) :: any
  def get(key) do
    :poolboy.transaction(__MODULE__, fn worker_pid -> Todo.Database.Worker.get(worker_pid, key) end)
  end
end
