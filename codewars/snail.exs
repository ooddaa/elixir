defmodule Snail do
  @doc """
  https://www.codewars.com/kata/521c2db8ddc89b9b7a0000c1/elixir

  Converts a matrix to a list by walking around its edges from the top-left going clockwise.

  ![snail walk](http://www.haan.lu/files/2513/8347/2456/snail.png)

  iex> Snail.snail( [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ] )
  [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]

  """

  @spec snail([[term]]) :: [term]

  # First solution
  # def snail(matrix), do: reducer(matrix, [])

  # def reducer([], acc), do: acc

  # def reducer([head | tail], acc) do
  #   new_acc =
  #     head ++ Enum.map(tail, fn row -> Enum.at(row, -1) end)

  #   new_matrix =
  #     Enum.map(tail, fn row ->
  #       {head, _tail} = Enum.split(row, -1)
  #       Enum.reverse(head)
  #     end)
  #     |> Enum.reverse()

  #     reducer(new_matrix, acc ++ new_acc)
  # end

  # Much better solution - just shave heads off =)
  def snail(matrix), do: reducer(matrix, [])
  defp reducer([], acc), do: acc
  defp reducer([head|tail], acc) do
    tail
    |> List.zip
    |> Enum.map(&Tuple.to_list(&1))
    |> Enum.reverse()
    |> reducer(acc ++ head)
  end
end

ExUnit.start()

defmodule SnailTest do
  use ExUnit.Case

  test "empty" do
    matrix = [[]]

    assert Snail.snail(matrix) == []
  end

  test "one digit" do
    matrix = [[1]]

    assert Snail.snail(matrix) == [1]
  end

  test "3x3 positions" do
    matrix = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]

    assert Snail.snail(matrix) == [1, 2, 3, 6, 9, 8, 7, 4, 5]
  end

  test "3x3 order" do
    matrix = [
      [1, 2, 3],
      [8, 9, 4],
      [7, 6, 5]
    ]

    assert Snail.snail(matrix) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "5x5 order" do
    matrix = [
      [1,   2,  3,  4,  5],
      [6,   7,  8,  9, 10],
      [11, 12, 13, 14, 15],
      [16, 17, 18, 19, 20],
      [21, 22, 23, 24, 25]]

    assert Snail.snail(matrix) == [1, 2, 3, 4, 5, 10, 15, 20, 25, 24, 23, 22, 21, 16, 11, 6, 7, 8, 9, 14, 19, 18, 17, 12, 13]
  end

  test "7x7 order" do
    matrix = [[1, 2, 3, 4, 5, 6], [20, 21, 22, 23, 24, 7], [19, 32, 33, 34, 25, 8], [18, 31, 36, 35, 26, 9], [17, 30, 29, 28, 27, 10], [16, 15, 14, 13, 12, 11]]

    assert Snail.snail(matrix) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]
  end
end


# def snail(matrix), do: tail_snail(matrix, [])

#   defp tail_snail([], acc), do: acc

#   defp tail_snail([head | tail], acc) do
#     IO.inspect(head, label: 'head', width: 10)
#     # IO.inspect(acc, label: 'acc', width: 10)
#     tail
#     |> List.zip()
#     # |> IO.inspect(label: 'zipped', width: 10)
#     |> Enum.map(&Tuple.to_list(&1))
#     |> Enum.reverse()
#     # |> IO.inspect(label: 'reversed', width: 10)
#     |> tail_snail(acc ++ head)
#     # |> IO.inspect(label: 'result', width: 10)
#   end
