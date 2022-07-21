defmodule Binaries do

# A binary is a chunk of bytes
# if the size of all values is not multiple of 8, it's a bitstring
  def main do

      IO.inspect(<<258::16>>) # <<1, 2>>
      IO.inspect(<<1::1, 1::1, 1::1, 0::1>>) # <<14::size(4)>>
      IO.inspect(<<1, 1, 1, 0>> <> <<5>>) # <<1, 1, 1, 0, 5>>

  end
end

Binaries.main()
