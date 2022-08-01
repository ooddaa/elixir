defmodule MyMapSet do
  @moduledoc """
  A MapSet is the implementation of a set —
  a store of unique values, where a value can be of any type.
  """
  def main do
    days = MapSet.new([:monday, :tuesday, :wednesday])
    MapSet.member?(days, :monday) # |> IO.inspect # true
    MapSet.member?(days, :thursday) # |> IO.inspect # false


    # ACCESS
    Enum.at(days, 1) # |> IO.inspect # :tuesday


    # PUT
    # Inserts value into map_set if map_set doesn't already contain it.
    days = MapSet.put(days, :thursday)
    MapSet.member?(days, :thursday) # |> IO.inspect # true


    # NO ORDERING OF ITEMS
    # IO.inspect days # #MapSet<[:monday, :thursday, :tuesday, :wednesday]>


    # CREATE FROM ENUMERABLE
    week = MapSet.new([:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday])


    # CREATE FROM ENUMERABLE WITH TRANSFORMATION
    weekend = MapSet.new(%{ day1: :friday, day2: :saturday, day3: :sunday }, fn { _k, v} -> v end) # |> IO.inspect()

    # Deletes value from map_set.
    MapSet.delete(weekend, :friday) # |> IO.inspect()
    # # Returns a set that is map_set1 without the members of map_set2.
    MapSet.difference(week, weekend) # |> IO.inspect() # #MapSet<[:monday, :thursday, :tuesday, :wednesday]>
    # # Checks if map_set1 and map_set2 have no members in common.
    MapSet.disjoint?(week, weekend) # |> IO.inspect() # false - and follow with intersection
    # # Returns a set containing only members that map_set1 and map_set2 have in common.
    MapSet.intersection(week, weekend) # |> IO.inspect() # #MapSet<[:friday, :saturday, :sunday]>
    # # Checks if two sets are equal.
    MapSet.equal?(week, weekend) # |> IO.inspect() # false
    # # Returns the number of elements in map_set.
    MapSet.size(week) # |> IO.inspect() # 7
    # # Checks if map_set1's members are all contained in map_set2
    MapSet.subset?(weekend, week) # |> IO.inspect() # true
    MapSet.subset?(week, weekend) # weekend # false

    # Returns a set containing all members of map_set1 and map_set2.
    MapSet.union(weekend, MapSet.new([:thebestdayever])) #|> IO.inspect() # #MapSet<[:friday, :saturday, :sunday, :thebestdayever]>


    # DEEP EQUALITY CHECKS?
    complex = MapSet.new([%{ a: 1, b: 2 }, %{ c: 3, d: 4 }, ]) # |> IO.inspect # #MapSet<[%{a: 1, b: 2}, %{c: 3, d: 4}]>

    MapSet.subset?(MapSet.new(Enum.at(complex, 0)), complex) # |> IO.inspect # false - does not do deep equality check

    complex2 = MapSet.new([[:banana]]) |> IO.inspect # #MapSet<[[:banana]]>
    complex3 = MapSet.new([:apple, [:banana], :coconut]) |> IO.inspect # #MapSet<[:apple, :coconut, [:banana]]>

    MapSet.subset?(MapSet.new(Enum.at(complex2, 0)), complex3) |> IO.inspect # false - does not do deep equality check
  end
end

MyMapSet.main()
