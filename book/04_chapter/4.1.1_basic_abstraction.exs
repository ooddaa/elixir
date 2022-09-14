defmodule :todo do
  @moduledoc """
  The basic version of the to-do list will support the following features:
  1. Creating a new data abstraction
  2. Adding new entries
  3. Querying the abstraction
  """
  def new(), do: %{}

  # TODO how do I check key is a Date?
  @spec add_entry(map, date, value) :: map
  def add_entry(todo_map, date, title) do
    Map.update(todo_map, date, [title], fn titles -> [title|titles] end)
  end

  @spec get_entry(map, date) :: value
  def get_entry(todo_map, date) do
    Map.get(todo_map, date, [])
  end

  @spec entries(map) :: [{ date, value }]
  def entries(todo_map) do
    Map.to_list(todo_map)
  end
end


:todo.new()
|> :todo.add_entry("lol", :lol)
|> IO.inspect(label: 'add_entry')
|> :todo.get_entry("lol")
|> IO.inspect(label: 'get_entry')

:todo.new()
|> :todo.get_entry("lol")
|> IO.inspect(label: 'get_entry')

:todo.new()
|> :todo.add_entry("lol", :lol)
|> :todo.add_entry(~D[2022-09-14], :Wednesday)
|> :todo.entries()
|> IO.inspect(label: 'entries')
