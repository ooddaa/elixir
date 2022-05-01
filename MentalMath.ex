defmodule MentalMath do
  def main do
    num = "0"
    result = IO.gets("#{num} * 11 = ? ") |> String.trim()
    IO.puts("(#{is_integer(result)})")

    unless(result == "0") do
      main()
    end

    # why this prints as many times as there are recursion calls?
    # all calls reference same result?
    # and then this block executes up the recursion stack? aaaaaaaaaaaaaaaaaaaabbb
    IO.puts("ok you can go do something useful now")
  end
end

MentalMath.main()
