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
    # my_str = "987"
    IO.puts("Integer? #{is_integer(my_int)}")
    # IO.puts("Integer? #{is_integer(my_str)} String? #{is_string(my_str)}")
    IO.puts("Is atom? #{is_atom(:London)}")

    range = 1..9
    IO.puts(range)
  end

  def data_stuff do
    # Integers
    my_int = 123
    int_check = if is_integer(my_int), do: "", else: "not"
    IO.puts "#{my_int} is#{int_check} an integer"

    # Floats
    my_float = 3.14
    float_check = if is_float(my_float), do: "", else: "not"
    IO.puts "#{my_float} is#{float_check} a float"

    # Atoms
    my_atom = :Elixir
    atom_check = unless is_atom(my_atom), do: "not", else: ""
    IO.puts "#{my_atom} is#{atom_check} an atom"
    IO.puts "my_atom === :Elixir is #{my_atom === :Elixir}"
    IO.puts ":\"Sleaford Mods\" == :\"Sleaford Mods\" is #{:"Sleaford Mods" == :"Sleaford Mods"}"

    # Range
    one_to_ten = 1..10

  end

  def control_flow do
    # if cond, do: this, else: that
    it_rains = true
    need_umbrella = if it_rains, do: "take it", else: "don't take it"
    IO.puts need_umbrella
  end

  def max(a,b) do
    if a >= b, do: a, else: b
  end
end


defmodule AnotherModule do
  # MyModule.engine()
  MyModule.data_stuff()
  # MyModule.control_flow()
  # IO.puts MyModule.max(12, 43)
end
