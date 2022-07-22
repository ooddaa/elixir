defmodule Fun do
  def main do
    lambda1 = fn x, y, z -> x + y + z end
    lambda2 = &(&1 + &2 + &3)
    IO.puts lambda1.(4, 5, 6) == lambda2.(4, 5, 6) # true
  end

  def closure do
    outside_var = 10
    lambda = fn -> IO.puts(outside_var) end
    outside_var = 99
    lambda.() # 10
  end
end

# Fun.main()
Fun.closure()
