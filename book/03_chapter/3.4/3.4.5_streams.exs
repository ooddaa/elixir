# Stream.scan == lazy reduce? https://hexdocs.pm/elixir/Stream.html#scan/3
# Stream.transform == lazy reduce? https://hexdocs.pm/elixir/Stream.html#transform/3

# defmodule :streams do


# end

# CONCAT
# stream = Stream.concat([1..4])
# Enum.to_list(stream)

# CYCLE
# Stream.cycle([1..4])
# Stream.cycle(stream)
# |> Enum.take(5)
# |> IO.inspect
# dbg()

# WITH INDEX
["Alice", "Bobby", "Chebu"]
|> Stream.with_index
|> Enum.map(&(IO.inspect("#{elem(&1,1) + 1}. #{elem(&1,0)}")))
# |> Enum.map(fn { employee, index } ->
#     IO.inspect("#{index + 1}. #{employee}")
# end)


# MAP
[-1, 9, "lol", 25, 99]
|> Stream.filter(&(is_number(&1) and &1 > 0))
|> Stream.map(&({ &1, :math.sqrt(&1) }))
|> Stream.with_index
|> Enum.each(fn { { input, sqrt }, index } ->
  IO.puts("#{index + 1}. sqrt(#{input}) = #{sqrt}")
end)
