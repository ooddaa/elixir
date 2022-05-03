defmodule MyModule do
  @moduledoc """
  Well, quite frankly, the best module out there.
  """

  def engine do
    # something
    # name = IO.gets("what's up stranger, what's your name? ") |> String.trim()
    # IO.puts("Hello #{name}")

    box = ["b", "c", a: "aaa"]
    # # abc
    # IO.puts(box)
    IO.puts(box[:a])
    do_stuff()
  end

  def do_stuff do
    my_int = 987
    my_str = "987"
    IO.puts("Integer? #{is_integer(my_int)}")
    # IO.puts("Integer? #{is_integer(my_str)} String? #{is_str(my_str)}")
    IO.puts("Is atom? #{is_atom(:London)}")

    range = 1..9
    IO.puts(range)
  end
end


defmodule AnotherModule do
  MyModule.engine()
end
