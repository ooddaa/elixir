defmodule Maps do
  @moduledoc """
  This is Elixir's Map.
  Map.get(map, key)
  Map.put(map, key, value)
  Map.delete(map, key)
  Map.merge(map1, map2)
  """
  # import Map
  # import IO
  import Enum

  @doc """
  Stringifies map. Hopefully...
  https://hexdocs.pm/elixir/1.12/typespecs.html
  """
  @spec map_to_strList(Map) :: list(String.t())
  def map_to_strList map do

    map(map,
      fn(tuple) -> "#{elem(tuple, 0)} => #{elem(tuple, 1)}" end
    )
  end

  @doc """
  Do some maps
  """
  def main do
    fruits = Map.new([{"apple", 10}, {"banana", 2}, {"orange", :none}])

    IO.inspect map_to_strList(fruits)
    IO.inspect(fruits)
  end


end

Maps.main()
