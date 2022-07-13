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
  end
end

MyLists.main()
