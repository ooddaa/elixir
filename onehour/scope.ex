apple = "apple"
b = true

defmodule One do
  @moduledoc """
  you should be aware of the fact the a module definition creates the module as its side-effect, so the module itself will be available globally.

  https://elixir-lang.readthedocs.io/en/latest/technical/scoping.html
  """
  # IO.puts(apple) # "apple"

  def main do
    # IO.puts(apple) # var does not exist?

    one()
    two = fn ->
      # IO.puts("two", apple) # no access to apple
      IO.puts("two")
    end

    # anonymous functions are not hoisted
    two.()

  end

  def one do
    IO.puts("one")
    # IO.puts(apple) # var doesnt exist
  end
end

One.main()
