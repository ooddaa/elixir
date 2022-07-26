# Keyword lists are often used for small-size key/value structures, where keys are atoms.
# https://hexdocs.pm/elixir/1.13/Keyword.html
defmodule Kewordlist do
  # keys are always :atoms
  # slower than maps, need to traverse whole list O(n)
  # insertion ordering not guaranteed - DO NOT PATTERN MATCH ON IT!
  def main do

    options = [
      "can have whitespace": :true,
      "@lol": :also_true,
      "123": :numbers_are_ok
    ]
    # options[:"@lol"] |> IO.inspect # :also_true
    # options[:"123"] |> IO.inspect # :numbers_are_ok

    days = [ { :monday, 1 }, { :tuesday, 2} ]
    days2 = [ monday: 1, tuesday: 2 ]

    # GET - returns first key match
    # Keyword.get(days, :monday) |> IO.inspect
    # Keyword.get(days, :sunday, "none") |> IO.inspect([ label: "lol"])
    # (days2[:monday] == days[:monday]) |> IO.inspect # true
    # (days2[:noday] == nil) |> IO.inspect # true


    duplicates = [ a: 1, a: 2] # |> IO.inspect # [ a: 1, a: 2]

    # GET_VALUES
    # returns all values where key matches

    # Keyword.get_values(duplicates, :a) |> IO.inspect # [1,2]


    # PUT
    # Keyword.put(options, :new, "hehe") |> IO.inspect
    # Keyword.put(options, :new, "hehe-2") |> IO.inspect # replaces :new


    # Keyword.put(duplicates, :a, 3) |> IO.inspect # replaces all :a with [a: 3]


    # DELETE
    # Keyword.delete(duplicates, :a) |> IO.inspect # []
    # Keyword.delete_first(duplicates, :a) |> IO.inspect # [a: 2]


    # MEMBERSHIP
    # IO.inspect (:monday in days) # false
    Keyword.has_key?(days, :monday) |> IO.inspect
  end

end

Kewordlist.main()
