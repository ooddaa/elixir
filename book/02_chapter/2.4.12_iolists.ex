# https://hexdocs.pm/elixir/IO.html#module-io-data
defmodule MyIOlist do
  @moduledoc """

  Building IO data is cheaper than concatenating binaries.

  A term of type IO data is a binary or a list containing bytes
  (integers within the 0..255 range) or nested IO data.

  ??? https://hexdocs.pm/elixir/IO.html#module-io-data
  The built-in iodata/0 type is defined in terms of iolist/0. An IO list is the same as IO data but it doesn't allow for a binary at the top level (but binaries are still allowed in the list itself).
  """
  def main do
    iolist = []
    iolist = [iolist, "This "]
    iolist = [iolist, 'is ']
    iolist = [iolist, ["going ", "to "]]
    iolist = [iolist, ["be ", ['huge ']]]
    iolist = [iolist, 65] # bytes in 0..255
    iolist = [iolist, [<<66, 67, 68>>]] # binaries, what have you
    iolist = [iolist, [?\s, ?!]] # ?symbol operator returns binary code for symbol
    IO.puts iolist # This is going to be huge ABCD !

    # CONVERT TO BINARY
    # https://hexdocs.pm/elixir/IO.html#iodata_to_binary/1
    IO.iodata_to_binary(iolist) # |> IO.inspect # "This is going to be huge ABCD !" coz everything can be represented as a byte 0..255. If there was a Unicode character, this would throw ArgumentError and we'd need to use IO.chardata_to_string/1

    # LENTGH
    IO.iodata_length(iolist) # |> IO.inspect # 31
  end

  def email(username, domain) do
    [username, ?@, domain]
  end

  def say_hello(name, username, domain) do
    IO.puts ['Hi ', name, ", your email is: ", email(username, domain)]
  end
end

MyIOlist.main()
# MyIOlist.say_hello('oda', "ooddaa", "gmail.com")
