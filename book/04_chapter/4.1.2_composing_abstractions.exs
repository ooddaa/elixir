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

  def add_entry(todo_list, date, title) do
    MultiDict.add(todo_list, date, title)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end

  def due_today(todo_list) do
    MultiDict.get(todo_list, Date.utc_today())
  end
end

TodoList.new()
|> TodoList.add_entry(~D[2022-09-15], "go to park")
|> TodoList.add_entry(~D[2022-09-15], "Slava's birthday")
|> TodoList.add_entry(~D[2022-09-16], "call at 10am, work")
|> TodoList.add_entry(~D[2022-09-17], "meet Ilya")
# |> TodoList.entries(~D[2022-09-16])
|> TodoList.due_today()
|> IO.inspect()
