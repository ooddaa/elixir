defmodule Result.Ok do
  defstruct code: :ok, value: nil

  @type t() :: %__MODULE__{ code: :ok, value: any() }
  @spec new(any()) :: t()
  def new(value), do: %Result.Ok{ code: :ok, value: value }

  defimpl Functor do
    def fmap(%Result.Ok{ code: :ok, value: value }, f),
    do: %Result.Ok{ code: :ok, value: f.(value) }
  end
end

defmodule Result.Err do
  defstruct code: :error, reason: nil

  @type t() :: %__MODULE__{ code: :error, reason: String.t() }
  @spec new(String.t()) :: t()
  def new(reason), do: %Result.Err{ code: :error, reason: reason }

  defimpl Functor do
    def fmap(%Result.Err{ code: :error, reason: reason }, _f),
    do: %Result.Err{ code: :error, reason: reason }
  end
end
