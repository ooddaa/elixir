defmodule Tuples do
  import IO

  def main do
    fruits = { "apple", "banana", "coconut", :true, 1 }
    puts elem(fruits, 1)
    puts elem(fruits, 3)

    fruits2 = put_elem(fruits, 0, "lol")
    puts elem(fruits2, 0)
  end

end

Tuples.main()
