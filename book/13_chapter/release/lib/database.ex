defmodule Todo.Database do
  @spec child_spec(any) :: none
  def child_spec(_) do
    db_settings = Application.fetch_env!(:todo, :database)

    # Node name is used to determine the database folder. This allows us to
    # start multiple nodes from the same folders, and data will not clash.

    db_folder = get_nodes_db_folder(node())
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

  defp get_nodes_db_folder(node) do
    db_settings = Application.fetch_env!(:todo, :database)
    [name_prefix, _] = "#{node}" |> String.split("@")
    "#{Keyword.fetch!(db_settings, :folder)}/#{name_prefix}/"
  end

  @doc """
  syncs db folder with the given node
  """
  def sync(source_node) do
    IO.puts("Found source node #{source_node |> to_string()}")
    source_db = get_nodes_db_folder(source_node)
    target_db = get_nodes_db_folder(node())

    case File.exists?(source_db) do
      true ->
        {:ok, files} = File.ls(source_db)
        IO.puts("Copying files: #{inspect files}")
        File.cp_r(source_db, target_db, on_conflict: fn source, destination ->
          case IO.gets("Overwriting #{destination} by #{source}. Type y/N to confirm/CANCEL. ") do
            "y\n" ->
              IO.puts("Overwritten")
              true
            "N\n" ->
              IO.puts("Cancelled")
              false
            _ ->
              IO.puts("Aborted")
              false
          end
        end)

      false ->
        IO.puts("Cannot find #{source_db}")
    end
  end
end
