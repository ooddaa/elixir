defmodule Tree do
  defstruct value: nil, children: []

  @type t() :: %__MODULE__{
          value: any(),
          children: [t()]
        }
  def new(value, children) do
    %Tree{value: value, children: children}
  end

  defimpl Functor do
    def fmap(%Tree{ value: value, children: [] }, f),
      do: %Tree{ value: f.(value), children: []}

    def fmap(%Tree{ value: value, children: children }, f) do
      %Tree{
        value: f.(value),
        children: Functor.fmap(children, fn x -> fmap(x, f) end)
      }
    end
  end
end

# tree =
#   %Tree{
#     value: 1,
#     children: [
#       %Tree{
#         value: 2,
#         children: []
#       },
#       %Tree{
#         value: 3,
#         children: [
#           %Tree{
#             value: 4,
#             children: []
#           }
#         ]
#       }
#     ]
#   }
