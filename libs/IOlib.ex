# https://hexdocs.pm/elixir/IO.html
# ??? IO devices maintain their position, which means subsequent calls to any reading or writing functions will start from the place where the device was last accessed. The position of files can be changed using the :file.position/2 function.

defmodule IOlib do
  def main do

  end

  def io_inspect_options do
    # https://hexdocs.pm/elixir/1.13/Inspect.Opts.html
    IO.inspect([100, 200, 300, :lol], [
      pretty: true,
      base: :binary,
      limit: 2,
      width: 3,
      syntax_colors: [number: :green, atom: :blue]
      ])

    # keyword brackets may be omitted
    IO.inspect([100, 200, 300, :lol],
      pretty: true,
      base: :binary,
      limit: 2,
      width: 3,
      syntax_colors: [number: :green, atom: :blue]
      )
  end

  @doc """
  https://hexdocs.pm/elixir/IO.html#module-chardata
  Chardata is very similar to IO data: the only difference is that integers in IO
  data represent bytes while integers in chardata represent Unicode code points.
  Bytes (byte/0) are integers within the 0..255 range, while Unicode code points
  (char/0) are integers within the 0..0x10FFFF range.
  """
  def chardata do
    # IO.chardata_to_string('this is chardata') # |> IO.inspect

    # ERROR
    # IO.iodata_to_binary(["The symbol for pi is: ", ?π]) # ArgumentError, coz ?π cannot be represented within 0..255 range ie as a byte

    IO.chardata_to_string(["The symbol for pi is: ", ?π]) # "The symbol for pi is: π"

    IO.chardata_to_string([0x0061, 'b', ?c]) # |> IO.inspect # "abc"
  end


  def get_user_input do
    input = IO.gets("what's your name? > ")
    IO.puts ["user's name is ", input] # adds \n automatically
    IO.write ["user's name is ", input] # does not add \n
  end

  @doc """
  https://hexdocs.pm/elixir/IO.html#stream/2
  Converts the IO device into an IO.Stream.
  Echoes whatever user inputs in terminal.
  """
  def echo do
    Enum.each(IO.stream(:stdio, :line), &IO.write/1)
  end
end

# IOlib.main()
# IOlib.chardata()
# IOlib.get_user_input()
IOlib.echo()
