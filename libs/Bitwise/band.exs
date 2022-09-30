import Bitwise

a = "101010"

# string to integer
{int42, ""} = a
  |> Integer.parse(2)
  # |> IO.inspect() # {42, ""}

# integer to string representation

str =
  int42
  |> Integer.to_string(2)
  # |> IO.inspect() # "101010"

# a == str # true


# band
band(int42, int42)
  |> IO.inspect(label: "band(42, 42)") # 42

{ int43, ""} =
  "101011"
    |> Integer.parse(2)
    # |> IO.inspect() # {43, ""}


# "101010"
# "101011"
# "101010"
# IO.inspect(Integer.parse("101010", 2)) # {42, ""}


band(int42, int43)
  |> IO.inspect(label: "band(42, 43)") # 42

{int44, ""} =
  "101100"
  |> Integer.parse(2)
  # |> IO.inspect() # {44, ""}

# "101010"
# "101100"
# "101000"
# band(int42, int44)
#   |> IO.inspect(label: "band(42, 44)") # 40 omg

# IO.inspect(Integer.parse("101000", 2))

# int42 = "101010"
# mask = "111111"
# band(int42, mask) == "101010"
#
# first negate bnot
# not_int42 = bnot(int42)
# "101010"
# "010101" bnot
# "111111"
# "010101"

# "101010"
# "010101" bnot
# "100000" mask
# "000000"

# IO.inspect(Integer.to_string(2**11, 2)) # "100000000000" // 12 length == 2048
# IO.inspect(Integer.to_string(2**11-1, 2)) # "11111111111" // 11 length == 2047

# {mask, ""} =
#   "100000"
#   |> Integer.parse(2)
#   |> IO.inspect(label: "100000") # 32

# IO.inspect(bnot(int42), label: "bnot(int42)") # -43
# IO.inspect(Integer.to_string(-43, 2), label: "-43 is ") # "-101011"
# IO.inspect(band(-43, mask), label: "band(-43, mask)") # 0

# "101010"
# "010101" bnot
# "111111" mask
# "010101"
{not_int42, ""} =
  "010101"
  |> Integer.parse(2)
  |> IO.inspect(label: "not_int42: 010101") # 21

# {mask1, ""} =
#   "111111"
#   |> Integer.parse(2)
#   |> IO.inspect(label: "111111") # 63

# IO.inspect(bnot(int42), label: "bnot(int42)") # -43
# IO.inspect(Integer.to_string(-43, 2), label: "-43 is ") # "-101011"
# IO.inspect(band(-43, mask1), label: "band(-43, mask1)") # 21

# band(int42, int44)
#   |> IO.inspect(label: "band(42, 44)") # 40 omg

# bxor
# "101010"
# "101011"
# "111110"
# IO.inspect(Integer.parse("111110", 2), label: "bxor(42, 43)") # {62, ""}
