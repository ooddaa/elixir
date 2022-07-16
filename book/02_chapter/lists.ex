# 2.4.4

defmodule MyLists do
  import IO

  def main do
    primes = [1, 3, 5, 7, 11]

    # LENGTH - O(n)!
    # puts length(primes) # 5

    # ACCESS
    # puts Enum.at(primes, 4, :nope) # 11
    # puts Enum.at(primes, 22, :nope) # :nope

    # CHECK PRESENCE
    # 5 in primes # true

    # REPLACE
    replaced = List.replace_at(primes, 0, 13)

    # INSERT
    inserted = List.insert_at(primes, 3, 13)

    # BAD CONCATENATION - O(n)
    concd = [1,2,3] ++ [4,5,6]

    # GOOD CONCATENATION - O(1)
    list_a = [1,2,3]
    list_b = [4,5,6]

    # head & tail
    # hd(list_a) # 1
    # tl(list_a) # [2,3]

    # list_ab = [ list_a | list_b ]
    list_ab = Enum.concat(list_a, list_b) # [1, 2, 3, 4, 5, 6]
    list_ab = Enum.concat([list_a, list_b]) # [1, 2, 3, 4, 5, 6]

    # [1 | []] # [1]
    # [1 | [ 2 | []]] # [1,2]
  end

  def print(val) do
    puts IO.inspect(val)
  end
end

MyLists.main()
