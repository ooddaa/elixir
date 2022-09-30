import Bitwise

# bnot(2) # -3
# bnot(1) # -2
# bnot(0) # -1
# bnot(-1) # 0
# bnot(-2) # 1

IO.inspect(Integer.to_string(bnot(2), 2))  # -11
IO.inspect(Integer.to_string(bnot(1), 2))  # -10
IO.inspect(Integer.to_string(bnot(0), 2))  # -1
IO.inspect(Integer.to_string(bnot(-1), 2)) # 0
IO.inspect(Integer.to_string(bnot(-2), 2)) # 1

IO.inspect(Integer.to_string(2, 2))  # 10
IO.inspect(Integer.to_string(1, 2))  # 1
IO.inspect(Integer.to_string(0, 2))  # 0
IO.inspect(Integer.to_string(-1, 2)) # -1
IO.inspect(Integer.to_string(-2, 2)) # -10
