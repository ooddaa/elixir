defmodule MyRange do
  def main do
    range = 1..10
    decreasing = 10..1
    # Enum.each(range, &IO.puts/1)

    first..last//step = range
    # IO.inspect(first)
    # IO.inspect(last == range.last and range.last == 10)
    # IO.inspect(step)

    # EMPTY RANGE
    Enum.to_list(1..10//-1) # |> IO.inspect # []

    # MEMBERSHIP
    # IO.puts 5 in range

    # WITH STEP
    Enum.to_list(1..9//3) # |> IO.inspect # [1,4,7]
    Enum.to_list(10..1//-2) # |> IO.inspect # [10, 8, 6, 4, 2]
    Enum.to_list(1..11//4) # |> IO.inspect # [1,5,9]

    # IMPLEMENTS ENUMERABLE PROTOCOL
    Enum.reduce(1..10, 0, &(&1 + &2)) # |> IO.inspect # 55
    Enum.sum(1..10) # |> IO.inspect # 55
    Enum.count(1..32) # |> IO.inspect # 32
    Enum.member?(1..45, 8) # |> IO.inspect # true

  end
end

MyRange.main()
