# https://hexdocs.pm/elixir/String.Chars.html
# https://hexdocs.pm/elixir/Protocol.html
defprotocol String.Chars do
  def to_string(thing)
end

defimpl String.Chars, for: Integer  do
  def to_string(integer) do
    "such a cute integer: #{Integer.to_string(integer)}"
  end
end

# String.Chars.to_string(123)
# |> IO.puts


# REFLECTION
# https://hexdocs.pm/elixir/Protocol.html#module-reflection
# String.Chars.__protocol__(:functions)
# |> IO.inspect()

# Enumerable.__protocol__(:functions)
# |> IO.inspect() # [count: 1, member?: 2, reduce: 3, slice: 1]

# Enumerable.__protocol__(:consolidated?)
# |> IO.inspect() # false
