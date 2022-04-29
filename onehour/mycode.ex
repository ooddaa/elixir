defmodule MyModule do
  def engine do
    # something
    name = IO.gets("what's up stranger, what's your name?") |> String.trim()
    IO.puts("Hello #{name}")
  end
end

MyModule.engine()
