# https://hexdocs.pm/elixir/Kernel.html#defstruct/1
# https://elixir-lang.org/getting-started/structs.html
defmodule Fraction do
  @moduledoc """
  Structs are BARE MAPS => no protocols are defined
  but Map module functions can be applied to structs
  """
  # defstruct a: nil, b: nil
  # @derive {Inspect, only: :a}
  # @derive {Enumerable, [:a, :b]}
  @enforce_keys [:a, :b]
  @type t :: %__MODULE__{a: integer, b: integer}
  defstruct [:a, :b]

  def new(a, b) do
    %Fraction{a: a, b: b}
  end

  def add(%Fraction{a: a1, b: b1}, %Fraction{a: a2, b: b2}) when b1 == b2 do
    %Fraction{a: a1 + a2, b: b1}
  end

  def add(%Fraction{a: a1, b: b1}, %Fraction{a: a2, b: b2}) do
    %Fraction{a: a1 * b2 + a2 * b1, b: b1 * b2}
  end

  def substract(%Fraction{a: a1, b: b1}, %Fraction{a: a2, b: b2}) when b1 == b2 do
    %Fraction{a: a1 - a2, b: b1}
  end

  def substract(%Fraction{a: a1, b: b1}, %Fraction{a: a2, b: b2}) do
    %Fraction{a: a1 * b2 - a2 * b1, b: b1 * b2}
  end

  def value(%Fraction{a: a, b: b}) do
    a / b
  end
end

# using struct/2 instead of %Fraction{} coz it's not compiled yet
# struct(Fraction, a: 1, b: 2)
# |> Fraction.value()
# |> IO.inspect()

# struct(Fraction, a: 1, b: 2)
# # |> Enum.to_list() # TODO need to @derive Enumerable protocol
# |> IO.inspect()

# struct(Fraction, a: 1, b: 2)
# |> Map.to_list()
# |> IO.inspect() # [__struct__: Fraction, a: 1, b: 2]

# struct(Fraction, a: 1, b: 2)
# |> Map.keys()
# |> IO.inspect() # [:__struct__, :a, :b]

# THESE WON'T WORK - structs need to be compiled first
# the struct was not yet defined or the struct is being
# accessed in the same context that defines it
# %Fraction{ a: 1, b: 2 }
# |> Fraction.value()
# |> IO.inspect()

# one_half = %Fraction{ a: 1, b: 2 }
# one_half.value()
# |> IO.inspect()
