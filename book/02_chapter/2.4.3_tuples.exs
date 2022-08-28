# 2.4.3
# put_elem(tuple, i, new_elem)
# elem(tuple, i)

defmodule Tuples do
  import IO

  def main do
    # CREATE
    fruits = { "apple", "banana", "coconut", :true, 1 }


    # ACCESS
    elem(fruits, 1)
    # |> IO.inspect # banana

    elem(fruits, 3)
    # |> IO.inspect # true


    # ADD
    fruits2 = put_elem(fruits, 0, "lol")
    elem(fruits2, 0)
    # |> IO.inspect # lol

    fruits3 = { { "hehe" } }
    elem(elem(fruits3, 0), 0)
    # |> IO.inspect # hehe
  end

end

Tuples.main()
