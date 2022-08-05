defmodule MyReduce do
  @moduledoc """
  https://hexdocs.pm/elixir/1.13.4/Enum.html#reduce/3
  """



  @spec map(list()) :: list()
  def map(list) do
    Enum.reduce(
      list,
      [],
      fn el, acc -> [ el * 2 | acc ] |> Enum.reverse end
    )
  end

  @spec map2(list, (any -> any)) :: list
  def map2(list, fun) do
    list
    |> Enum.reduce([], fn x, acc -> [ fun.(x) | acc ] end)
    |> Enum.reverse
  end


  @spec filter(list, (any -> boolean)) :: list
  def filter(list, fun) do
    list
    |> Enum.reduce([], fn x, acc ->
        if fun.(x) === :true, do: [ x | acc ], else: acc
    end)
    |> Enum.reverse
  end

  @doc """
  list [key1, val1, val2] |> list_to_map
  %{ key1: [val1, val2] }
  """
  @spec list_to_map(list, (any -> any)) :: map
  def list_to_map(list, fun) do
    list
    |> Enum.reduce(
      Map.new(),
      fn x, acc ->
        case fun.(x) do
          [key | values] -> Map.put(acc, key, values)
          true -> acc
        end
      end
    )
  end

  @doc """
  [
  ["key1", "val1", "val2", "val1"],
  ["key2", "val1", "val2", "val3", "val3"]
  ]
  =>
  %{
  "key1" => #MapSet<["val1", "val2"]>,
  "key2" => #MapSet<["val1", "val2", "val3"]>
  }
  """
  @spec makeMatrix(list, (any -> any)) :: map
  def makeMatrix(list, fun) do
    list
    |> Enum.reduce(
      Map.new(),
      fn x, acc ->
        case fun.(x) do
          # can we work with this value?
          [key | values] ->
            Map.update(acc, key, MapSet.new(values), fn map_set ->
              Enum.map(values, fn val -> MapSet.put(map_set, val)end)
            end)
          # cannot work with this value, go on
          true -> acc
        end
      end
    )
  end
end

# MyReduce.map([1,2,3,4,5])
# |> IO.inspect

# MyReduce.map2([1,2,3,4,5], fn x -> x * 2 end)
# |> IO.inspect # [2, 4, 6, 8, 10]

# https://hexdocs.pm/elixir/1.13.4/Kernel.html#rem/2
is_even = fn x -> rem(x, 2) == 0 end

# MyReduce.filter([1,2,3,4,5,6,7,8], is_even)
# |> IO.inspect # [2, 4, 6, 8]
# MyReduce.filter([1,3,5,7], is_even)
# |> IO.inspect # []
# MyReduce.filter([1,2,4,6,8], is_even)
# |> IO.inspect # [2, 4, 6, 8]

fun = fn x -> x end
# MyReduce.list_to_map([['key1', 'val1', 'val2'], ['key2', 'val1', 'val2']], fun)
# |> IO.inspect # %{'key1' => ['val1', 'val2']}

MyReduce.makeMatrix([
  ["key1", "val1", "val2", "val1"],
  ["key2", "val1", "val2", "val3", "val3"]
  ], fun)
# |> IO.inspect #
