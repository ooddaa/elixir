defmodule :positive_integers do

  def print(n) when is_number(n) and n < 1, do: IO.inspect {:error, "I only accept positive integers", n: n}
  def print(1), do: IO.puts 1
  def print(n) do
    IO.puts n
    print(n-1)
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
  def sum_tr([], acc \\ 0), do: acc
  def sum_tr([head | tail], acc) do
    sum_tr(tail, acc + head)
  end
end

# :sum_of_list.sum([1,2,3,4,5]) |> IO.inspect
# :sum_of_list.sum_tr([1,2,3,4,5]) |> IO.inspect


defmodule :practice do
  def list_len([], len \\ 0), do: len
  def list_len([head|tail], len) do
    list_len(tail, len + 1)
  end
end

:practice.list_len([]) |> IO.inspect
:practice.list_len([1,2]) |> IO.inspect
:practice.list_len([1,2,[3]]) |> IO.inspect
