apple = "apple"
b = true

defmodule One do
  @moduledoc """
  you should be aware of the fact the a module definition creates the module as its side-effect, so the module itself will be available globally.

  https://elixir-lang.readthedocs.io/en/latest/technical/scoping.html

  https://elixir-lang.readthedocs.io/en/latest/technical/scoping.html#named-functions-and-modules
  First, defining a named function does not introduce a new binding into the current scope
  Second, named functions cannot directly access surrounding scope, one has to use unquote to achieve that
  """
  # IO.puts(apple) # "apple"

  def main do
    IO.puts(unquote(apple)) # need to unquote to access var from outer scope

    two = fn ->
      IO.puts(unquote(apple)) # same here
    end

    # one() # ok

    # anonymous functions are not hoisted
    two.()

  end

  def one do
    IO.puts("one")
    # IO.puts(apple) # var doesnt exist
  end

  # main()  # not gonna work
end

One.main()
