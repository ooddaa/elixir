defmodule :practice do
  # header
  def list_len(list, len \\ 0)
  def list_len([], len), do: len
  def list_len([_ | tail], len), do: list_len(tail, len + 1)

  @doc """
  A range/2 function that takes two integers, from and to,
  and returns a list of all integer numbers in the given range
  """

  # VARIANT 1
  # def range(from, to, list \\ []) do
  #   case from > to do
  #     true -> Enum.reverse(list)
  #     false -> range(from + 1, to, [from|list])
  #   end
  # end

  # VARIANT 2
  # def range(from, to, list \\ [])
  # def range(from, to, list) when from > to, do: Enum.reverse(list)
  # def range(from, to, list), do: range(from + 1, to, [from | list])

  # VARIANT 3
  def range(from, to) when from > to, do: []
  def range(from, to), do: [ from, range(from + 1, to) ] |> List.flatten


  @doc """
  A positive/1 function that takes a list and returns another list that
  contains only the positive numbers from the input list
  """

  # def positive(list, acc \\ [])
  # def positive([], acc), do: Enum.reverse(acc)

  # def positive([head | tail], acc) do
  #   case head > 0 do
  #     true -> positive(tail, [head | acc])
  #     false -> positive(tail, acc)
  #   end
  # end

  # VARIANT 2
  def positive([]), do: []
  def positive([head | tail]) when head > 0, do: [head, positive(tail)] |> List.flatten
  def positive([_ | tail]), do: [positive(tail)] |> List.flatten

end

# :practice.list_len([]) |> IO.inspect
# :practice.list_len([1,2]) |> IO.inspect
# :practice.list_len([1,2,[3]]) |> IO.inspect

# :practice.range(1,5)  |> IO.inspect # [1, 2, 3, 4, 5]
# :practice.range(7,11) |> IO.inspect #

# [1, 2, 3, 4, 5]
# :practice.positive([-1, 1, 2, -2, 3, -4, 4, 5]) |> IO.inspect()
