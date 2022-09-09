defmodule :positive_integers do
  def print(n) when is_number(n) and n < 1,
    do: IO.inspect({:error, "I only accept positive integers", n: n})

  def print(1), do: IO.puts(1)

  def print(n) do
    IO.puts(n)
    print(n - 1)
  end
end

# :positive_integers.print(3)
# {:error, "I only accept positive integers", [n: -3]}
# {:error, _, arg} = :positive_integers.print(-3)
# arg[:n] |> IO.inspect

defmodule :sum_of_list do
  # non tail-recursive
  def sum([]), do: 0

  def sum([head | tail]) do
    head + sum(tail)
  end

  # tail-recursive
  def sum_tr(list, acc \\ 0)
  def sum_tr([], acc), do: acc

  def sum_tr([head | tail], acc) do
    sum_tr(tail, acc + head)
  end
end

# :sum_of_list.sum([1,2,3,4,5]) |> IO.inspect
# :sum_of_list.sum_tr([1,2,3,4,5]) |> IO.inspect

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

end

# :practice.list_len([]) |> IO.inspect
# :practice.list_len([1,2]) |> IO.inspect
# :practice.list_len([1,2,[3]]) |> IO.inspect

# :practice.range(1,5) |> IO.inspect # [1, 2, 3, 4, 5]
# :practice.range(7,11) |> IO.inspect #

# [1, 2, 3, 4, 5]
# :practice.positive([-1, 1, 2, -2, 3, -4, 4, 5]) |> IO.inspect()
# :practice.range(7,11) |> IO.inspect #
