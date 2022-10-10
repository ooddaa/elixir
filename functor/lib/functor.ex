defprotocol Functor do
  @moduledoc """
  https://blog.appsignal.com/2022/07/26/how-to-write-a-functor-in-elixir.html
  """
  def fmap(a, f)
end

defimpl Functor, for: List do
  @spec fmap(list, (list -> list)):: List
  def fmap(a, f), do: :lists.map(f, a)
end

defimpl Functor, for: Map do
  def fmap(a, f) do
    a
    |> Map.to_list()
    |> Functor.fmap(fn { key, value } ->
      { key, f.(value) }
    end)
    |> Map.new()
  end
end

defimpl Functor, for: Tuple do
  def fmap({:ok, value}, f), do: {:ok, f.(value)}
  def fmap({:error, reason}, _f), do: {:error, reason}
end

# Functor.fmap([1000,2000,3000], fn x -> x + 10 end)
# |> IO.inspect()

# Functor.fmap(%{ a: 1, b: 2 }, fn x -> x + 10 end)
