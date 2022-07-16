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
    # fruits = Map.new([{"apple", 10}, {"banana", 2}, {"orange", :none}])
    # IO.inspect(fruits)

    # veggies = %{ :tomato => 1, :broccoli => 123, :cucumber => "lol" }
    # IO.inspect veggies
    # puts veggies.tomato
    # puts veggies.cucumber
    # puts Map.get(veggies, :tomato)
    # puts Map.get(veggies, :apple, :nope)
    # Map.fetch(veggies, :tomato) # {:ok, 1}

    # veggies = Map.put(veggies, :carrot, "yummy")
    # puts Map.get(veggies, :carrot)

    veggies = %{ tomato: 1, broccoli: 123, cucumber: "lol" } # all keys are atoms
    veggies_ = veggies
    # veggies = %{ "joi" => 1, broccoli: 123, cucumber: "lol" }
    # veggies = %{ "joi" => 1, 123 => 123, cucumber: "lol" }

    # DELETE
    #
    # veggies = Map.delete(veggies, "joi")

    # UPDATE
    # https://hexdocs.pm/elixir/1.13/Map.html#update/4
    # veggies = Map.update(veggies, 123, 0, fn e -> 9 end) # aaa really?
    # [nine, lol] = Map.values(veggies)
    # puts nine

    # FILTER
    # https://hexdocs.pm/elixir/1.13/Map.html#filter/2
    filter = fn {key, _val} -> key === :broccoli end
    broccoli = Enum.filter(Map.to_list(veggies_), filter) # [broccoli: 123]
    broccoli = Map.filter(veggies_, filter) # %{broccoli: 123}
    IO.inspect broccoli

    # REJECT
    # https://hexdocs.pm/elixir/1.13/Map.html#reject/2
    rejector = fn {key, _val} -> key === :broccoli end
    no_broccoli = Enum.reject(Map.to_list(veggies_), rejector) # [cucumber: "lol", tomato: 1]
    no_broccoli = Map.reject(veggies_, rejector) # %{cucumber: "lol", tomato: 1}
    IO.inspect no_broccoli

    # POP
    # https://hexdocs.pm/elixir/1.13/Map.html#pop/3
    remove_broccoli = Map.pop(veggies_, :broccoli) # {123, %{cucumber: "lol", tomato: 1}}
    IO.inspect remove_broccoli
  end


end

Maps.main()
