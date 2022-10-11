# https://en.wikipedia.org/wiki/Permutations_of_a_permutation
# https://www.youtube.com/watch?v=toCqrVmQPiY&list=PLlx2izuC9gjhc6TOzoeL-ovXXsvjJi22f&index=9

# четность перестановки

# # непрерывный ряд чисел  // может быть и прерывным, но без повторений
# list  = [5,  13,  3,  7,  11, 14, 6,  9,  12, 2, 15,  4,  8,  1,  10]
# # кол-во еще не учтеных пар для каждого числа check = (n-1)*n/2
# pairs = [14, 13,  12, 11, 10, 9,  8,  7,  6,  5,  4,  3,  2,  1,  0] # 105
# # считаем количество неправильных пар, еще не учтеных для каждого числа
# wrong = [4,  11,  2,  4,  7,  8,  3,  4,  5,  1,  4,  1,  1,  0,  0]

# list  = [1, 2,  3,  4]
# pairs = [3, 2,  1,  0] # 12
# wrong = [(3-3), (2-2), (1-1), (0-0)] = [0, 0, 0, 0] = 0

# list  = [2, 1,  3,  4]
# pairs = [3, 2,  1,  0]
# wrong = [(3-2), (2-2), (1-1), (0-0)] = [1, 0, 0, 0] = 1

# list  = [2, 3,  1,  4]
# pairs = [3, 2,  1,  0]
# wrong = [(3-2), (2-1), (1-1), (0-0)] = [1, 1, 0, 0] = 2

# list  = [2, 3,  4,  1]
# pairs = [3, 2,  1,  0]
# wrong = [(3-2), (2-1), (1-0), (0-0)] = [1, 1, 1, 0] = 3

# list  = [2, 1,  4,  3]
# pairs = [3, 2,  1,  0]
# wrong = [(3-2), (2-2), (1-0), (0-0)] = [1, 0, 1, 0] = 2

# list  = [4, 3,  2,  1]
# pairs = [3, 2,  1,  0]
# wrong = [(3-0), (2-0), (1-0), (0-0)] = [3, 2, 1, 0] = 6
# [{4, 3, 3}, {3, 2, 2}, {2, 1, 1}, {1, 0, 0}]

defmodule Permutations do
  # [4, 3, 2, 1]
  # [{4, 3, 3}, {3, 2, 2}, {2, 1, 1}, {1, 0, 0}]
  def worker([]), do: []
  def worker([head|tail]) do

    pairs = length(tail)
    new_head =
        {
          head,
          pairs,
          calculate_wrong_pairs(tail, head, pairs)
        }

      case tail do
        [] -> [new_head]
        tail -> [new_head|worker(tail)]
      end
  end

  defp calculate_wrong_pairs([], _, _), do: 0
  defp calculate_wrong_pairs(list, val, pairs) do
    # we walk the list left -> right, find how many numbers x are val < x and return pairs - sum(val < x)
    list
    |> Enum.count(fn x -> val < x end)
    |> then(fn sum -> pairs - sum end)
  end

  @typedoc """
  {
    initial value,
    how many new pairs it has to check,
    how many of those pairs are wrong order
  }
  """
  @type t() :: { integer(), integer(), integer() }
  @spec sum([t()]) :: integer()
  def sum(list) do
    # [{4, 3, 3}, {3, 2, 2}, {2, 1, 1}, {1, 0, 0}] == 6
    list
    |> Enum.map(fn { _, _, val } -> val end)
    |> Enum.sum()
  end
end

Permutations.worker([5,  13,  3,  7,  11, 14, 6,  9,  12, 2, 15,  4,  8,  1,  10])
# Permutations.worker([4, 3, 2, 1])
# Permutations.worker([1, 2,  3,  4])
# Permutations.worker([])
|> IO.inspect(label: 'semi-final')
|> Permutations.sum()
|> IO.inspect(label: 'final')
