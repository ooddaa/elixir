defmodule MyModule do
  import IO
  @moduledoc """
  Well, quite frankly, the best module out there.
  """

  def engine do
    # something
    # name = gets("what's up stranger, what's your name? ") |> String.trim()
    # puts("Hello #{name}")

    box = ["b", "c", a: "aaa"]
    # # abc
    # puts(box)
    puts(box[:a])
    do_stuff()
  end

  def do_stuff do
    my_int = 987
    # my_str = "987"
    puts("Integer? #{is_integer(my_int)}")
    # puts("Integer? #{is_integer(my_str)} String? #{is_string(my_str)}")
    puts("Is atom? #{is_atom(:London)}")

    range = 1..9
    puts(range)
  end

  def data_stuff do
    # Integers
    my_int = 123
    int_check = if is_integer(my_int), do: "", else: "not"
    puts "#{my_int} is#{int_check} an integer"

    # Floats
    my_float = 3.14
    float_check = if is_float(my_float), do: "", else: "not"
    puts "#{my_float} is#{float_check} a float"

    # Atoms
    my_atom = :Elixir
    atom_check = unless is_atom(my_atom), do: "not", else: ""
    puts "#{my_atom} is#{atom_check} an atom"
    puts "my_atom === :Elixir is #{my_atom === :Elixir}"
    puts ":\"Sleaford Mods\" == :\"Sleaford Mods\" is #{:"Sleaford Mods" == :"Sleaford Mods"}"

    # Range
    range = 1..10
    puts "puts 1 in range is #{1 in range}" # 2 in range |> puts

    Enum.each(1..3, &puts/1)

  end

  def control_flow do
    # if cond, do: this, else: that
    it_rains = true
    need_umbrella = if it_rains, do: "take it", else: "don't take it"
    puts need_umbrella
  end

  def max(a,b) do
    if a >= b, do: a, else: b
  end
end


defmodule AnotherModule do
  # MyModule.engine()
  MyModule.data_stuff()
  # MyModule.control_flow()
  # puts MyModule.max(12, 43)
end
