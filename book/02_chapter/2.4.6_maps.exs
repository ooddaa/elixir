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
  # import IO

  @doc """
  Stringifies map. Hopefully...
  https://hexdocs.pm/elixir/1.12/typespecs.html
  """
  @spec map_to_strList(Map) :: list(String.t())
  def map_to_strList(map) do
    map(
      map,
      fn tuple -> "#{elem(tuple, 0)} => #{elem(tuple, 1)}" end
    )
  end

  @doc """
  Do some maps
  """

  # def main do
  #   # CREATE
  #   # Map.new([{"apple", 10}, {"banana", 2}, {"orange", :none}])
  #   # |> IO.inspect(label: "fruits")

  #   # all keys are atoms
  #   # veggies = %{ :tomato => 1, :broccoli => 123, :cucumber => "lol" }
  #   # or
  #   veggies = %{ tomato: 1, broccoli: 123, cucumber: "lol" }
  #   veggies_ = veggies
  #   # veggies = %{ "joi" => 1, broccoli: 123, cucumber: "lol" }
  #   # veggies = %{ "joi" => 1, 123 => 123, cucumber: "lol" }
  #   # |> IO.inspect

  #   # ACCESS
  #   veggies.tomato
  #   # |> IO.inspect

  #   Map.get(veggies, :tomato)
  #   # |> IO.inspect

  #   Map.get(veggies, :apple, :nope)
  #   # |> IO.inspect

  #   Map.fetch(veggies, :tomato)
  #   # |> IO.inspect # {:ok, 1}

  #   # ADD
  #   Map.put(veggies, :carrot, "yummy")
  #   # |> IO.inspect # %{broccoli: 123, carrot: "yummy", cucumber: "lol", tomato: 1}

  #   # DELETE
  #   # veggies = Map.delete(veggies, "joi")

  #   # UPDATE
  #   # may add new key
  #   # https://hexdocs.pm/elixir/1.13/Map.html#update/4
  #   # if just want to add a new key:value, use Map.put
  #   Map.update(veggies, 123, 0, fn e -> 9 end) # aaa really?
  #   # |> IO.inspect

  #   # UPDATE (unsafe version)
  #   # equvalent to spreading in JS
  #   %{ veggies | :tomato => 0 }
  #   # |> IO.inspect

  #   # would not add non-existing key
  #   # %{ veggies | :eggplant => 123 } # (KeyError) key :eggplant not found

  #   # FILTER
  #   # https://hexdocs.pm/elixir/1.13/Map.html#filter/2
  #   filter = fn { key, _val } -> key === :broccoli end
  #   # [broccoli: 123]
  #   Enum.filter(Map.to_list(veggies_), filter)
  #   # %{broccoli: 123}
  #   Map.filter(veggies_, filter)
  #   # |> IO.inspect

  #   # REJECT
  #   # https://hexdocs.pm/elixir/1.13/Map.html#reject/2
  #   rejector = fn {key, _val} -> key === :broccoli end
  #   Enum.reject(Map.to_list(veggies_), rejector)
  #   # |> IO.inspect # [cucumber: "lol", tomato: 1]

  #   Map.reject(veggies_, rejector)
  #   # |> IO.inspect # %{cucumber: "lol", tomato: 1}

  #   # POP
  #   # https://hexdocs.pm/elixir/1.13/Map.html#pop/3
  #   Map.pop(veggies_, :broccoli)
  #   # |> IO.inspect # { 123, %{ cucumber: "lol", tomato: 1 } }

  #   # MERGE
  #   Map.merge(veggies_, %{carrots: true})
  #   |> Map.merge(%{carrots: false})
  #   # |> IO.inspect(label: 'merge') # carrots: false as maps have unique keys

  #   # custom logic
  #   Map.merge(
  #     veggies_,
  #     %{cucumber: "not lol"},
  #     fn key, v1, v2 ->
  #       if key == :cucumber, do: "it works", else: v2
  #     end
  #     )

  #   # |> IO.inspect # %{broccoli: 123, cucumber: "it works", tomato: 1}

  #   # PUT
  #   # https://hexdocs.pm/elixir/1.13/Map.html#put/3
  #   Map.put(veggies_, :artishock, "yammi")
  #   # |> IO.inspect

  #   # puts value under key, unless key already exists
  #   Map.put_new(%{a: 1}, :b, 2)
  #   # |> IO.inspect # %{a: 1, b:2}
  #   Map.put_new(%{a: 1, b: 2}, :a, 3)
  #   # |> IO.inspect # %{a: 1, b:2}
  # end

  def map_with_mapset do
    test = %{
      key1: MapSet.new([:val1, :val2]),
      key2: MapSet.new([:val1, :val2, :val3])
    }

    # |> IO.inspect
    # %{key1: #MapSet<[:val1, :val2]>, key2: #MapSet<[:val1, :val2, :val3]>}

    # FIND KEY AND ADD TO SET

    Map.get(test, :key1)
    |> IO.inspect(label: 'before')
    |> MapSet.put(:val3)
    |> IO.inspect(label: 'after')

    # before: #MapSet<[:val1, :val2]>
    # after: #MapSet<[:val1, :val2, :val3]>
  end

  def test do
    acc = %{
      key1: MapSet.new([:val1, :val2]),
      key2: MapSet.new([:val1, :val2, :val3]),
      key3: MapSet.new([:val1, :val2, :val3])
    }

    key2 = :key2
    key3 = :key3
    val4 = :val4

    Map.update(acc, key3, MapSet.new([val4]), fn map_set ->
      MapSet.put(map_set, val4)
    end)

    # |>
  end

  def iterate_map(map) do
    Map.new(Enum.map(map, fn {k, v} ->
      # IO.inspect({k, v}, label: 'iterate_map')
      { k, Enum.map(v, & &1 + 10) }
    end))
  end
end

# Maps.main

# Maps.map_with_mapset
# |> IO.inspect

# Maps.test
# |> IO.inspect

Maps.iterate_map(%{a: [3, 4], b: [3, 4]})
|> IO.inspect
