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
    print Enum.take(list_ab, 4)

    # [1 | []] # [1]
    # [1 | [ 2 | []]] # [1,2]
  end

  def print(val) do
    puts IO.inspect(val)
  end

  def nested_list do
    list = [[1]]
    # |> IO.inspect
    list = [
      ["1791", "3644", "true", "2019-08-13 09:13:39"],
      ["1791", "7075", "true", "2019-08-13 09:13:39"],
      ["5121", "7075", "true", "2019-08-22 07:53:40"],
      ["5121", "7032", "true", "2019-08-22 07:53:40"],
      ["5121", "9981", "true", "2019-08-22 07:53:40"],
      ["6840", "7032", "true", "2019-08-28 17:43:15"],
      ["6840", "9981", "true", "2019-08-28 18:32:47"],
      ["6291", "7317", "true", "2019-08-25 20:14:18"],
      ["45", "11237", "true", "2019-09-24 15:03:47"],
      ["2700", "6122", "true", "2019-08-14 15:21:10"],
      ["7704", "4566", "true", "2019-09-01 20:52:34"]
    ]
    # |> IO.inspect
  end
end

# MyLists.main()
MyLists.nested_list()
