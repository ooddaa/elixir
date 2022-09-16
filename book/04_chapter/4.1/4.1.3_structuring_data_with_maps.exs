defmodule MultiDict do
  def new(), do: %{}

  def add(dict, key, value) do
    Map.update(dict, key, [value], &[value|&1])
  end

  def get(dict, key) do
    Map.get(dict, key, [])
  end
end

defmodule TodoList do
  def new(), do: MultiDict.new()

  def add_entry(todo_list, entry) do
    MultiDict.add(todo_list, entry.date, entry)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end

  def due_today(todo_list) do
    MultiDict.get(todo_list, Date.utc_today())
  end
end


TodoList.new()
|> TodoList.add_entry(%{ date: ~D[2022-09-15], title: "Slava's birthday" })
|> TodoList.add_entry(%{ date: ~D[2022-09-15], title: "go to park" })
|> TodoList.add_entry(%{ date: ~D[2022-09-16], title: "call at 10am, work" })
|> TodoList.add_entry(%{ date: ~D[2022-09-16], title: "meet Artem at 12am" })
|> TodoList.add_entry(%{ date: ~D[2022-09-17], title: "meet Ilya" })
# |> TodoList.due_today()
|> TodoList.entries(~D[2022-09-16])
|> IO.inspect()
