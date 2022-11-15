# https://elixirschool.com/en/lessons/storage/ets
# https://www.erlang.org/doc/man/dets.html
{:ok, table} = :dets.open_file(:a, [type: :set]) # { :ok, :a }
table |> :dets.insert({ :a, 1 }) # :ok
table |> :dets.insert({ :a, 2 }) # :ok
table |> :dets.lookup(:a) # [a: 2]
table |> :dets.close() # :ok
