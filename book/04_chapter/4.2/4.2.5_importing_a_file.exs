defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

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

defmodule TodoList.CsvImporter do
  def import(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.map(&String.replace(&1, "\"", ""))
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(fn [date, task] ->
      [ year, month, day ] = String.split(date, "/")
        |> Enum.map(&(String.to_integer(&1)))

      case Date.new(year, month, day) do
        { :ok, date } -> %{date: date, task: task}
        true -> throw("not a date")
      end
    end)
    |> Enum.map(&(&1))
  end
end

TodoList.CsvImporter.import("todos.csv")
|> TodoList.new()
|> IO.inspect()
