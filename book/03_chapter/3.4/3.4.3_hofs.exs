Enum.each([1..3], fn x -> x * 2 end)
# |> IO.inspect() # :ok

Enum.map([1..3], fn x -> x * 2 end)
# |> IO.inspect() # [2, 4, 6]

Enum.map([1..3], &(&1 * 2))
# |> IO.inspect() # [2, 4, 6]

Enum.filter([1..3], &(rem(&1, 2) == 0))
# |> IO.inspect() # [2]

defmodule :hofs do

  def missing_fields(map, required_fields) do
    case Enum.filter(required_fields,
    &(not Map.has_key?(map, &1))) do
      [] -> map
      missing_fields -> missing_fields
    end
  end
end

:hofs.missing_fields(%{a: 1, b: 2}, [:a, :b, :c, :d])
# |> IO.inspect(label: 'missing_fields')

Enum.reduce([1,2,3], 0, &+/2)
# |> IO.inspect(label: 'reduced sum 1 == 6: ')

Enum.reduce(
  [1,2, "crap", false, 3],
  0,
  &(case is_number(&1) do
    true -> &1 + &2
    false -> &2
  end)
)
# |> IO.inspect(label: 'reduced sum 2 == 6: ')

Enum.reduce(
  [1,2, "crap", false, 3],
  0,
  fn
    element, acc when is_number(element) -> element + acc
    _, acc -> acc
  end
)
# |> IO.inspect(label: 'reduced sum 3 == 6: ')

# BEST WAY
defmodule :num_helper do
  def sum_nums(enum), do: Enum.reduce(enum, 0, &add_nums/2)

  defp add_nums(num, acc) when is_number(num), do: num + acc
  defp add_nums(_, acc), do: acc

end

:num_helper.sum_nums([1,2, "crap", false, 3])
# |> IO.inspect(label: 'reduced sum 4 == 6: ')
