defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  test "single character" do

    # assert Parser.run("a") == [ {"a"}, ""]
    # assert Parser.run("Z") == [ {"Z"}, ""]

    Parser.run("abc")
    |> IO.inspect(label: 'RESULT')
  end

end
