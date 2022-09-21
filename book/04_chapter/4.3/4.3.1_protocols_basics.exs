# https://hexdocs.pm/elixir/String.Chars.html
defprotocol String.Chars do
  def to_string(thing)
end

defimpl String.Chars, for: Integer  do
  def to_string(integer) do
    "such a cute integer: #{Integer.to_string(integer)}"
  end
end

String.Chars.to_string(123)
|> IO.puts
