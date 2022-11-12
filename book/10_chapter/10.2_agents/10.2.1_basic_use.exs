{:ok, pid} = Agent.start_link(fn -> %{ count: 0, name: :lol } end)

pid
|> Agent.get(fn state -> state.count end)
|> IO.inspect()

pid
|> Agent.update(fn state -> %{ state | count: state.count + 1 } end)

pid
|> Agent.get(fn state -> state.count end)
|> IO.inspect()

pid
|> Agent.cast(fn state -> %{ state | name: :not_lol } end)

defmodule :adder do
  def add(state, arg), do: %{ state | count: state.count + arg }
end

pid
|> Agent.cast(:adder , :add, [100])

pid
|> Agent.get(fn state -> state end)
|> IO.inspect() # %{count: 101, name: :not_lol}
