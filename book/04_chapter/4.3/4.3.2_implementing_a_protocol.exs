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



TodoList.new([%{date: ~D[2022-09-15], title: "go to park"}])
|> IO.puts() # #TodoList{ auto_id: 2, entries_size: 1 }
# |> IO.inspect()
