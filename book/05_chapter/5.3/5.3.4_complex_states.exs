defmodule TodoServer do
  def start do
    spawn(fn ->
      loop(TodoList.new())
    end)
  end

  def loop(todo_list) do
    new_todo_list = receive do
      message -> process_message(todo_list, message)
    end
    loop(new_todo_list)
  end

  def add_entry(server_pid, new_entry) do
    send(server_pid, {:add, new_entry})
  end

  defp process_message(todo_list, {:add, new_entry}) do
    todo_list
    |> TodoList.add_entry(new_entry)
  end


  # def entries1(server_pid) do
  #   send(server_pid, {:entries})
  # end

  # defp process_message1(todo_list, {:entries}) do
  #   todo_list
  #   |> TodoList.entries()
  #   |> IO.inspect()

  #   todo_list
  # end


  def entries(server_pid) do
    send(server_pid, {:entries, self()})

    receive do
      {:todo_entries, entries} -> entries
    after
      2000 -> {:error, :timeout}
    end
  end

  defp process_message(todo_list, {:entries, caller}) do
    send(caller, {:todo_entries, TodoList.entries(todo_list)})
    todo_list
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
end
