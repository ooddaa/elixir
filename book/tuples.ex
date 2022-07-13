# 2.4.3
# put_elem(tuple, i, new_elem)
# elem(tuple, i)

defmodule Tuples do
  import IO

  def main do
    fruits = { "apple", "banana", "coconut", :true, 1 }
    puts elem(fruits, 1) # banana
    puts elem(fruits, 3) # true

    fruits2 = put_elem(fruits, 0, "lol")
    puts elem(fruits2, 0) # lol

    fruits3 = { { "hehe" } }
    puts elem(elem(fruits3, 0), 0) # hehe
  end

end

Tuples.main()
