defmodule SplitStrings do
  import IO

  @doc """
  Chunks a string in groups of two, adding trailing _ to the last chunck if uneven
  https://hexdocs.pm/elixir/1.12/typespecs.html
  """
  @spec my(String.t()) :: list(String.t())
  # @spec my(<<>>) :: list(<<>>)
  def my(str) do
    case String.length(str) do
      0 ->
        []

      _ ->
        chnkd =
          Enum.chunk_every(String.to_charlist(str), 2)
          |> Enum.map(fn val -> List.to_string(val) end)

        chnkd =
          if String.length(Enum.at(chnkd, -1)) === 1,
            do: List.replace_at(chnkd, -1, Enum.at(chnkd, -1) <> "_"),
            else: chnkd

        # IO.inspect(chnkd)
    end
  end

  def my2(str) do
    # rv =
    str
    |> to_charlist()
    |> Enum.chunk_every(2, 2, '_')
    |> Enum.map(&to_string/1)
    # IO.inspect(rv)
  end








  def solution1(str) do
    str
    |> to_charlist() # Kernel.to_char_list() https://hexdocs.pm/elixir/1.13/Kernel.html#to_charlist/1
    |> Enum.chunk_every(2, 2, '_') # https://hexdocs.pm/elixir/1.13/Enum.html#chunk_every/4
    |> Enum.map(&to_string/1) #Kernel.to_string() https://hexdocs.pm/elixir/1.13/Kernel.html#to_string/1
  end
end

SplitStrings.my2("abv")
