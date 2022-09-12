test = fn
  {:square, a} -> a * a
  {:rectangle, a, b} -> a * b
  {:circle, r} -> r * r * 3.14
  _ -> 0
end

# test.({:haha, 5}) |> IO.inspect(label: 'unknown')
# test.({:square, 5}) |> IO.inspect(label: 'square')
# test.({:circle, 5}) |> IO.inspect(label: 'circle')
# test.({:rectangle, 5, 3}) |> IO.inspect(label: 'rectangle')


# MULTICLAUSE LAMBDA WITH GUARDS
test_num = fn
  x when is_number(x) and x > 0 -> :positive
  x when is_number(x) and x < 0 -> :negative
  # x when x === 0 -> :zero
  0 -> :zero
end

# test_num.(1) |> IO.inspect(label: '>0')
# test_num.(-1)|> IO.inspect(label: '<0')
# test_num.(0) |> IO.inspect(label: '0')


# EXPERIMENTING
larger_than_two? = fn
  x when is_number(x) and x > 2 -> true
  _ -> false
end

only_add_larger_than_twos = fn
  list -> Enum.reduce(list, 0, fn
    (val, acc) ->
      case larger_than_two?.(val) do
        true -> acc + val
        false -> acc
      end
  end)
end

only_add_larger_than_twos.([1,2,3,4,5]) # 12
|> IO.inspect(label: '12?')

# V2 eliminates need for case do clause in reducer
larger_than_two_v2? = fn
  x when is_number(x) and x > 2 -> x
  _ -> 0
end

only_add_larger_than_twos_v2 = fn
  list -> Enum.reduce(list, 0, fn
    (val, acc) -> acc + larger_than_two_v2?.(val)
  end)
end

only_add_larger_than_twos_v2.([1,2,3,4,5]) # 12
|> IO.inspect(label: '12?')
