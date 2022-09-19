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
    entry = Map.put(entry, :id, todo_list.auto_id)
    # %TodoList{
    #   todo_list |
    #   auto_id: todo_list.auto_id + 1,
    #   # Map.update makes no sense here as auto_id increments each time, we should use Map.put
    #   entries: Map.update(
    #     todo_list.entries,
    #     todo_list.auto_id,
    #     entry,
    #     &Map.new/1)
    #   }

    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)
    %TodoList{ todo_list |
      entries: new_entries,
      auto_id: todo_list.auto_id + 1
    }
  end

  def get_entry(todo_list, date) do
    # {1, %{date: ~D[2022-09-15], title: "Slava's birthday"}},
    # VARIANT 1
    # Enum.filter(todo_list.entries, fn { _id, entry } ->
    #   entry.date == date
    # end)

    # VARIANT 2
    todo_list.entries
    |> Stream.filter(fn { _id, entry } -> entry.date == date end)
    |> Enum.map(fn { _id, entry } -> entry end)
  end

  # WITH NEW ENTRY MAP
  def update_entry(todo_list, id, new_entry) do
    case Map.fetch(todo_list.entries, id) do
      :error -> todo_list
      { :ok, _entry } ->
        new_entries = Map.put(todo_list.entries, id, Map.put(new_entry, :id, id))
        %TodoList{ todo_list | entries: new_entries }
    end
  end

  # WITH UPDATER FUNCTION
  def update_entry2(todo_list, id, updater) do
    case Map.fetch(todo_list.entries, id) do
      :error -> todo_list
      { :ok, entry } ->
        new_entries = Map.put(todo_list.entries, id, updater.(entry))
        %TodoList{ todo_list | entries: new_entries }
    end
  end

  def entries(todo_list), do: Map.to_list(todo_list)
end

# TodoList.new()
# |> TodoList.add_entry(%{date: ~D[2022-09-15], title: "Slava's birthday"})
# |> TodoList.add_entry(%{date: ~D[2022-09-15], title: "go to park"})
# |> TodoList.add_entry(%{date: ~D[2022-09-16], title: "call at 10am, work"})
# |> TodoList.add_entry(%{date: ~D[2022-09-16], title: "meet Artem at 12am"})
# |> TodoList.add_entry(%{date: ~D[2022-09-17], title: "meet Ilya"})
# |> TodoList.add_entry(%{date: ~D[2022-09-17], title: "smth else"})
# |> TodoList.get_entry(~D[2022-09-17])
# |> IO.inspect()

# TodoList.new()
# |> TodoList.add_entry(%{date: ~D[2022-09-15], title: "Slava's birthday"})
# |> TodoList.update_entry(1, %{date: ~D[2022-09-15], title: "ADCC finals"})
# |> TodoList.entries()
# |> IO.inspect()

# TodoList.new()
# |> TodoList.add_entry(%{date: ~D[2022-09-15], title: "Slava's birthday"})
# |> TodoList.update_entry2(1, &Map.put(&1, :title, "ADCC finals"))
# |> TodoList.entries()
# |> IO.inspect()
