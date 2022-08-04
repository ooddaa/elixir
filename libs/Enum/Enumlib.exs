defmodule Enumlib do
  @moduledoc """
  all functions work in linear time O(n)
  all function are EAGER - be careful feeding infinite collections :)

  Implement Enumerable protocol:
  Lists Maps, MapSets, Range
  File.stream!
  """

  def main do

    # WITH MAPS
    map = %{ a: 1, b: 2 }
    Enum.map(map, fn { k, v } -> %{ k => v*2 } end) # |> IO.inspect # map [%{a: 2}, %{b: 4}]
    Enum.map(map, fn { k, v } -> { k, v*2 } end) # |> IO.inspect # keyword [a: 2, b: 4]
    Enum.map(map, fn { k, v } -> MapSet.new([k, v*2 ]) end) # |> IO.inspect # [#MapSet<[2, :a]>, #MapSet<[4, :b]>]

    Enum.map(map, fn { _k, v } -> v end) |> Enum.sum # |> IO.inspect # 3


    # MEMBERSHIP
    Enum.member?(map, { :a, 1 } ) # |> IO.inspect # true - matched
    Enum.member?(map, :lol) # |> IO.inspect # false

    Enum.member?([1,2,3,4], 3) # |> IO.inspect # true
    Enum.member?([1,2,[3],4], 3) # |> IO.inspect # false
    Enum.member?([1,2,[3],4], [3]) # |> IO.inspect # true


    # ACCESS
    Enum.at(map, 0, :none) # |> IO.inspect # {:a, 1}
    Enum.at(map, 3, :none) # |> IO.inspect # :none


    # TRUTHINESS

    # ALL
    # Returns true if all elements in enumerable are truthy
    Enum.all?(map) # |> IO.inspect # true

    # ANY
    # Returns true if at least one element in enumerable is truthy.
    Enum.any?([true, false]) # |> IO.inspect # true
    Enum.any?([false, false, nil]) # |> IO.inspect # false
    Enum.any?([0]) # |> IO.inspect # TRUE !!!

    # CHUNK_BY/2 CHUNK_BY/4
    # Splits enumerable on every element for which fun returns a new value.
    list = [1,1,2,2,3,3,4,4]
    Enum.chunk_by(list, &(rem(&1, 2) == 1)) # |> IO.inspect # [[1, 1], [2, 2], [3, 3], [4, 4]]
    Enum.chunk_every(list, 2) # |> IO.inspect # [[1, 1], [2, 2], [3, 3], [4, 4]]
    # Returns list of lists containing count elements each, where each new chunk starts step elements into the enumerable.
    # step - count == gap
    list2 = 1..10 |> Enum.map(&Kernel.to_string/1)
    Enum.chunk_every(list2, 2, 1) |> IO.inspect # [["1", "2"], ["2", "3"], ["3", "4"]..
    Enum.chunk_every(list2, 2, 2) |> IO.inspect # [["1", "2"], ["3", "4"], ["5", "6"]..
    Enum.chunk_every(list2, 2, 3) |> IO.inspect # [["1", "2"], ["4", "5"], ["7", "8"]..

  end

  def reduce do
    # https://hexdocs.pm/elixir/1.13.4/Enum.html#reduce/3
    list = [
      ["1791", "3644", "true", "2019-08-13 09:13:39"],
      ["1791", "7075", "true", "2019-08-13 09:13:39"],
      ["5121", "7075", "true", "2019-08-22 07:53:40"],
      ["5121", "7032", "true", "2019-08-22 07:53:40"],
      ["5121", "9981", "true", "2019-08-22 07:53:40"],
      ["6840", "7032", "true", "2019-08-28 17:43:15"],
      ["6840", "9981", "true", "2019-08-28 18:32:47"],
      ["6291", "7317", "true", "2019-08-25 20:14:18"],
      ["45", "11237", "true", "2019-09-24 15:03:47"],
      ["2700", "6122", "true", "2019-08-14 15:21:10"],
      ["7704", "4566", "true", "2019-09-01 20:52:34"],
    ]

    Enum.reduce(list, Map.new(),
      fn (element, acc) ->
        [job_id, user_id, direction, time] = element
        # acc
        # |> IO.inspect(label: 'acc')
        case Map.has_key?(acc, user_id) do
          false -> Map.put(acc, user_id, MapSet.new())
          true -> acc
        end
        |> IO.inspect(label: 'case')
        # Map.get(acc, user_id) |> IO.inspect
        |> Map.get(user_id)
        # |> IO.inspect(label: 'Map.get(user_id)')
        |> MapSet.put(job_id)
        acc
        # |> IO.inspect(label: 'return')
      end
    )
    |> IO.inspect(label: 'rv')

  end
end

# Enumlib.main()
Enumlib.reduce()
