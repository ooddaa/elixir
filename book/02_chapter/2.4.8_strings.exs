defmodule Strings do
  import IO

  def main do
#     # MULTILINE
#     puts("this
# spans
# multiple
# lines
# 👍\n
# ")


#     # ESCAPES
#     puts("
# \t tab

# \r \\r
# newline\n
# ")
#     # SIGILS
#     puts(~s(lol))
#     puts ~s(yes interpolation \#{3+3} = #{3+3})
#     puts ~S(no interpolation \#{3+3} = #{3+3})


#     # HEREDOCS
#     puts """
#     LIKE DOCUMENTATION
#     """

    # CONCATENATION
    # string = ~s(con) <> "cat" <> """
    # enation
    # """ <> <<105, 115>> <> " " <> IO.chardata_to_string(Kernel.to_charlist("👍")) <> IO.chardata_to_string('😁')

    # # and make an IO device while we are at it
    # # https://hexdocs.pm/elixir/1.13/StringIO.html
    # {:ok, pid} = StringIO.open(string)
    # # write to it
    # IO.write(pid, " whopwhop") # {"concatenation\nis 👍😁", " whopwhop"}

    # # or ask user's input
    # # result of the function is a tuple, not a pid
    # {:ok, res} = StringIO.open(
    #   string,
    #   fn pid ->
    #     input = IO.gets("add smth > ")
    #     IO.write(pid, "user said: #{input}")
    #     StringIO.contents(pid)
    #   end
    # )
    # IO.inspect(res) # {"concatenation\nis 👍😁", "user said: asdff\n"}
    # puts is_pid(res) # false

    # StringIO.contents(pid)
    # |> IO.inspect # {"concatenation\nis 👍😁", " whopwhop"}
    # StringIO.flush(pid)
    # StringIO.close(pid)


    # TO STRING
    # Converts the argument to a string according to the String.Chars protocol.
    to_string('lol') # |> IO.inspect # "lol"

  end

  @spec char_to_string(char()) :: String.t()
  def char_to_string (char) do
    chardata_to_string(char)
  end

  @spec print_charlist_as_string() :: none
  def print_charlist_as_string do
    Enum.each(0..255, fn elm -> puts ~s(#{elm} -> #{char_to_string(<<elm>>)}) end)
  end

  # https://hexdocs.pm/elixir/1.13/IO.html#gets/2
  # IO.gets("What is your name?\n")
  # https://hexdocs.pm/elixir/1.13/StringIO.html
end

Strings.main()
# Strings.print_charlist_as_string()
