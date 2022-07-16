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
  import IO

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
    # IO.inspect(fruits)

    veggies = %{ :tomato => 1, :broccoli => 123, :cucumber => "lol" }
    # IO.inspect veggies
    # puts veggies.tomato
    # puts veggies.cucumber
    # puts Map.get(veggies, :tomato)
    # puts Map.get(veggies, :apple, :nope)
    # Map.fetch(veggies, :tomato) # {:ok, 1}

    veggies = Map.put(veggies, :carrot, "yummy")
    # puts Map.get(veggies, :carrot)

    veggies = %{ tomato: 1, broccoli: 123, cucumber: "lol" } # all keys are atoms
    veggies = %{ "joi" => 1, broccoli: 123, cucumber: "lol" }
    veggies = %{ "joi" => 1, 123 => 123, cucumber: "lol" }
    veggies = Map.delete(veggies, "joi")
    veggies = Map.update(veggies, 123, 0, fn e -> 999 end) # aaa really?
    IO.inspect veggies
  end


end

Maps.main()
