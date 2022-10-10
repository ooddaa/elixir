defmodule BinaryTree do
  defstruct value: nil, left: [], right: []

  @type t() :: %__MODULE__{
          value: any(),
          left: t(),
          right: t()
        }

  def new(value, left, right ) do
    %BinaryTree{value: value, left: left, right: right}
  end

  defimpl Functor do
    def fmap(%BinaryTree{ value: value, left: left, right: right }, f) do
      %BinaryTree{
        value: f.(value),
        left: case left do
          nil -> nil
          left -> Functor.fmap(left, f)
        end,
        right: case right do
          nil -> nil
          right -> Functor.fmap(right, f)
        end
      }
    end
  end
end

# btree =
#   %BinaryTree{
#     value: 1,
#     left: %BinaryTree{
#       value: 2,
#       left: %BinaryTree{
#         value: 3,
#         left: nil,
#         right: nil
#       },
#       right: %BinaryTree{
#         value: 4,
#         left: nil,
#         right: nil
#       }
#     },
#     right: nil
#   }
