# 2.4.4

defmodule MyLists do
  import IO

  def main do
    primes = [1, 3, 5, 7, 11]
    puts length(
      primes
    ) # 5

    puts Enum.at(primes, 4, :nope) # 11
    puts Enum.at(primes, 22, :nope) # :nope

    puts 5 in primes


    replaced = List.replace_at(primes, 0, 13)
    inserted = List.insert_at(primes, 3, 13)
    puts IO.inspect(replaced)
    puts print(inserted)
  end

  def print(val) do
    IO.inspect(val)
  end
end

MyLists.main()
