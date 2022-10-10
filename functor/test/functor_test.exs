defmodule FunctorTest do
  use ExUnit.Case
  doctest Functor

  test "greets the world" do
    assert Functor.hello() == :world
  end
end
