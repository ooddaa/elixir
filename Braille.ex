defmodule Braille do
  def printPattern do
    num = "0"
    result = IO.gets("0 * 11 = ? ") |> String.trim()
    IO.puts("(#{is_integer(result)})")

    unless(result == "0") do
      printPattern()
    end

    # why this prints as many times as there are recursion calls?
    # all calls reference same result?
    # and then this block executes up the recursion stack?
    IO.puts("ok you can go")
  end
end

Braille.printPattern()
