defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  # VARIAN 1
  # def new(list, todo_list \\ %TodoList{})
  # def new([], todo_list), do: todo_list
  # def new([head | tail], todo_list) do
  #   new(
  #     tail,
  #     todo_list |> TodoList.add_entry(head)
  #     )
  # end

  # VARIAN 2
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

entries = [
  %{date: ~D[2022-09-15], title: "Slava's birthday"},
  %{date: ~D[2022-09-15], title: "go to park"},
  %{date: ~D[2022-09-16], title: "call at 10am, work"},
  %{date: ~D[2022-09-16], title: "meet Artem at 12am"},
  %{date: ~D[2022-09-17], title: "meet Ilya"},
  %{date: ~D[2022-09-17], title: "smth else"}
]

TodoList.new(entries)
|> TodoList.entries()
|> IO.inspect()
