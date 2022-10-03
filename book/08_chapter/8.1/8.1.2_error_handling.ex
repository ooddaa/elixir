# https://hexdocs.pm/elixir/1.13/Kernel.html#defexception/1
defmodule MyFancyError do
  defexception [:message]

  @impl true
  def exception(val) do
    msg = "this aint shmancy: #{inspect val}"
    %MyFancyError{message: msg}
  end
end

# https://hexdocs.pm/elixir/1.13/Kernel.SpecialForms.html#try/1
try_helper = fn fun ->
  result = try do
    fun.()
    IO.puts("no error")

    rescue
      MyFancyError -> IO.puts("Fancy error's rescued")
      x in SyntaxError ->
        IO.puts("No SyntaxError!!")
        IO.puts(inspect x)
      x ->
        IO.puts("Just rescue every error and bind it")
        IO.puts(inspect x)

    catch
      :error, value ->
        IO.puts("Caught a RuntimeError:\n #{inspect value}")
        value

      :throw, value ->
        IO.puts("Caught a Throw:\n #{inspect value}")
        value

      # :exit, value ->
      #   IO.puts("Caught an Exit:\n #{inspect value}")
      #   value
      kind, value when kind in [:exit] ->
        IO.puts("Caught an Exit:\n #{inspect value}")
        value

      type, value ->
        IO.puts("Error:\n #{inspect type}\n #{inspect value}")
        value
    after
      IO.puts("cleaning up resources")
  end

  IO.inspect(result) # %RuntimeError{message: "AAAA"} || %{val: "BBBB"} || %{val: "CCCC"}
end

try_helper.(fn ->
  raise("AAAA") # :error, %RuntimeError{message: "AAAA"}
end)

try_helper.(fn ->
  # throw("BBBB") # :throw, "BBBB"
  throw(%{ val: "BBBB"}) # :throw, %{val: "BBBB"}
end)

try_helper.(fn ->
  # exit("CCCC") # :exit, "CCCC"
  exit(%{ val: "CCCC"}) # :exit, %{val: "CCCC"}
end)

try_helper.(fn ->
  raise MyFancyError, "DDDD" # :error, %MyFancyError{message: "this aint shmancy: \"DDDD\""}
end)

# x = 2
# y = try do
#   1 / x
# rescue
#   ArithmeticError ->
#     :infinity
# else
#   y when y < 1 and y > -1 ->
#     :small
#   _ ->
#     :large
# end

# IO.puts(y) # :small
