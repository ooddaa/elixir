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

  def sum([head | tail]), do: head + sum(tail)

  # tail-recursive
  def sum_tr(list, acc \\ 0)
  def sum_tr([], acc), do: acc

  def sum_tr([head | tail], acc), do: sum_tr(tail, acc + head)
end

# :sum_of_list.sum([1,2,3,4,5]) |> IO.inspect
# :sum_of_list.sum_tr([1,2,3,4,5]) |> IO.inspect
