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

  # VARIANT 2 - better
  def range(from, to, list \\ [])
  def range(from, to, list) when from > to, do: Enum.reverse(list)
  def range(from, to, list), do: range(from + 1, to, [from | list])

  @doc """
  A positive/1 function that takes a list and returns another list that
  contains only the positive numbers from the input list
  """

  def positive(list, acc \\ [])
  def positive([], acc), do: Enum.reverse(acc)

  def positive([head | tail], acc) do
    case head > 0 do
      true -> positive(tail, [head | acc])
      false -> positive(tail, acc)
    end
  end

  # want to write positive/1
  # NOPE It is not possible to recur on anonymous functions in Elixir.
  # https://stackoverflow.com/questions/21982713/recursion-and-anonymous-functions-in-elixir
  # def positive2(list) do
  #   worker = fn
  #     [], acc -> Enum.reverse(acc)
  #     [head | tail], acc when head > 0 -> worker.(tail, [head | acc])
  #     _ -> worker.(tail, acc)
  #   end
  #   worker.(list, [])
  # end

end

# :practice.list_len([]) |> IO.inspect
# :practice.list_len([1,2]) |> IO.inspect
# :practice.list_len([1,2,[3]]) |> IO.inspect

# :practice.range(1,5) |> IO.inspect # [1, 2, 3, 4, 5]
# :practice.range(7,11) |> IO.inspect #

# [1, 2, 3, 4, 5]
# :practice.positive([-1, 1, 2, -2, 3, -4, 4, 5]) |> IO.inspect()
