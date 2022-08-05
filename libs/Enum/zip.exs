defmodule :my_zip do

  @doc """
  [
    ["key1", "val1", "val2", "val1"],
    ["key2", "val1", "val2", "val3"],
  ]
  =>

  [
    ["val1", "key1", "val2", "val1"],
    ["val1", "key2", "val2", "val3"],
  ]
  """

  @spec swap_top_columns(list(list)) :: list(list)
  def swap_top_columns(matrix) do
    Enum.zip(matrix)
    |> swap_a_b
    # |> IO.inspect(label: 'after swap')
    |> Enum.map(&Tuple.to_list(&1))
    |> Enum.zip
    |> Enum.map(&Tuple.to_list(&1))

  end

  defp swap_a_b([]), do: IO.puts('something wrong!')
  defp swap_a_b([ head | [ head2 | tail ]]), do: [ head2 | [ head | tail ]]


end

:my_zip.swap_top_columns(
  [
    ["key1", "val1", "val2", "val1"],
    ["key2", "val1", "val2", "val3"],
  ]
)
|> IO.inspect
