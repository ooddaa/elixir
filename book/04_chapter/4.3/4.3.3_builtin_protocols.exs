# Collectable
# https://hexdocs.pm/elixir/Collectable.html#content
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

  # VARIANT 1
  # defimpl Collectable, for: TodoList  do
  #   def into(original) do
  #     collector = fn
  #       updated_acc, {:cont, entry} -> TodoList.add_entry(updated_acc, entry)
  #       updated_acc, :done -> updated_acc
  #       _updated_acc, :halt -> :ok
  #       end
  #     { original, collector }
  #   end
  # end

  # VARIANT 2
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



# [
# %{date: ~D[2022-09-15], title: "Slava's birthday"},
# %{date: ~D[2022-09-15], title: "go to park"},
# %{date: ~D[2022-09-16], title: "call at 10am, work"},
# %{date: ~D[2022-09-16], title: "meet Artem at 12am"},
# %{date: ~D[2022-09-17], title: "meet Ilya"},
# %{date: ~D[2022-09-17], title: "smth else"}
# ]
# |> Enum.into(TodoList.new())
# |> IO.puts() # #TodoList{ auto_id: 7, entries_size: 6 }
