defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new(), do: %TodoList{}

  @doc """
  1. Set the ID for the entry being added.
  2. Add the new entry to the collection.
  3. Increment the auto_id field.
  """
  def add_entry(todo_list, entry) do
    # struct(TodoList,
    #   auto_id: todo_list.auto_id + 1,
    #   entries: Map.update(todo_list.entries, todo_list.auto_id, [entry], &[entry | &1])
    # )
    %TodoList{
      todo_list |
      auto_id: todo_list.auto_id + 1,
      entries: Map.update(
        todo_list.entries,
        todo_list.auto_id,
        entry,
        &Map.new/1)
      }
  #   entry = Map.put(entry, :id, todo_list.auto_id)
  #   new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)
  #   %TodoList{ todo_list |
  #     entries: new_entries,
  #     auto_id: todo_list.auto_id + 1
  # }
  end

  def get_entry(todo_list, date) do
    # {1, %{date: ~D[2022-09-15], title: "Slava's birthday"}},
    # VARIANT 1
    # Enum.filter(todo_list.entries, fn { _id, entry } ->
    #   entry.date == date
    # end)

    # VARIANT 2
    # todo_list.entries
    # |> Stream.filter(fn { _id, entry } -> entry.date == date end)
    # |> Enum.map(fn { _id, entry } -> entry end)
  end
end

TodoList.new()
|> TodoList.add_entry(%{date: ~D[2022-09-15], title: "Slava's birthday"})
|> TodoList.add_entry(%{date: ~D[2022-09-15], title: "go to park"})
|> TodoList.add_entry(%{date: ~D[2022-09-16], title: "call at 10am, work"})
|> TodoList.add_entry(%{date: ~D[2022-09-16], title: "meet Artem at 12am"})
|> TodoList.add_entry(%{date: ~D[2022-09-17], title: "meet Ilya"})
|> TodoList.get_entry(~D[2022-09-16])
|> IO.inspect()
