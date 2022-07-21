

defmodule Smth do

  def main do
    StringIO.open("foo", fn pid ->
      input = IO.gets(pid, ">")
      IO.write(pid, "The input was #{input}")
      StringIO.contents(pid)
    end)
  end
end

Smth.main()
