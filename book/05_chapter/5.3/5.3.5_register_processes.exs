defmodule TodoServer do
  def start do
    pid = spawn(fn ->
      loop(TodoList.new())
    end)
    Process.register(pid, :server_pid)
    IO.puts(inspect pid)
  end

  def loop(todo_list) do
    new_todo_list = receive do
      message -> process_message(todo_list, message)
      # invalid_message ->
      #   IO.puts("invalid_message: #{invalid_message}")
      #   todo_list
    end
    loop(new_todo_list)
  end


  # INTERFACE FUNCTIONS
  def add_entry(new_entry) do
    send(:server_pid, {:add_entry, self(), new_entry})

    receive do
      {:added_entry, updated_todo_list} -> updated_todo_list
    after
      2_000 -> {:error, :timeout}
    end
  end

  def entries() do
    send(:server_pid, {:entries, self()})

    receive do
      {:todo_entries, entries} -> entries
    after
      2_000 -> {:error, :timeout}
    end
  end

  def update_entry(id, updater) do
    send(:server_pid, {:update_entry, self(), id, updater})

    receive do
      {:updated_entry, updated_todo_list} -> updated_todo_list
    after
      2_000 -> {:error, :timeout}
    end
  end

  def delete_entry(id) do
    send(:server_pid, {:delete_entry, self(), id})

    receive do
      {:entry_deleted, updated_todo_list} -> updated_todo_list
    after
      2_000 -> {:error, :timeout}
    end
  end


  defp process_message(todo_list, {:add_entry, caller, new_entry}) do
    updated_todo_list = TodoList.add_entry(todo_list, new_entry)
    send(caller, {:added_entry, updated_todo_list})
    updated_todo_list
  end

  defp process_message(todo_list, {:entries, caller}) do
    send(caller, {:todo_entries, TodoList.entries(todo_list)})
    todo_list
  end

  defp process_message(todo_list, {:update_entry, caller, id, updater}) do
    updated_todo_list = TodoList.update_entry(todo_list, id, updater)
    send(caller, {:updated_entry, updated_todo_list})
    updated_todo_list
  end

  defp process_message(todo_list, {:delete_entry, caller, id}) do
    updated_todo_list = TodoList.delete_entry(todo_list, id)
    send(caller, {:entry_deleted, updated_todo_list})
    updated_todo_list
  end

  def test do
    todos = [ %{date: ~D[2022-09-15], title: "go to park"}, %{date: ~D[2022-09-17], title: "meet Ilya"} ]
    TodoServer.add_entry(Enum.at(todos, 0))
    TodoServer.add_entry(Enum.at(todos, 1))
  end
end

defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  defimpl String.Chars, for: TodoList do
    def to_string(todo_list) do
      # @protocol == Elixir.String.Chars
      # @for == Elixir.TodoList
    """
    #TodoList{ auto_id: #{todo_list.auto_id}, entries_size: #{map_size(todo_list.entries)} }
    """
    end
  end

  defimpl Collectable, for: TodoList  do
    def into(original), do: { original, &collector/2 }

    defp collector(updated_acc, {:cont, entry}), do: TodoList.add_entry(updated_acc, entry)
    defp collector(updated_acc, :done), do: updated_acc
    defp collector(_updated_acc, :halt), do: :ok
  end

  def new(entries \\ []) do
    entries
    |> Enum.reduce(
      %TodoList{},
      &(add_entry(&2, &1))
    )
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)
    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  def entries(todo_list), do: Map.to_list(todo_list)

  def update_entry(todo_list, id, updater) do
    case Map.fetch(todo_list.entries, id) do
      :error -> todo_list
      { :ok, entry } ->
        new_entries = Map.put(todo_list.entries, id, updater.(entry))
        %TodoList{ todo_list | entries: new_entries }
    end
  end

  def delete_entry(todo_list, id) do
    { _, new_entries } = todo_list.entries
    |> pop_in([id])

    %TodoList{ entries: new_entries, auto_id: todo_list.auto_id }
  end
end
