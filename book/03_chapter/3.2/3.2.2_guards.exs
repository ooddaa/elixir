defmodule :with_guards do
  # def test(x) when is_number(x) and x > 0 do
  #   :positive
  # end
  # def test(0), do: :zero
  # def test(x) when is_number(x) and x < 0 do
  #   :negative
  # end

  def test(x) when is_number(x) and x > 0, do: {:positive, x}
  def test(0), do: {:zero, 0}
  def test(x) when is_number(x) and x < 0, do: {:negative, x}
end

:with_guards.test(1)  |> IO.inspect
:with_guards.test(0)  |> IO.inspect
:with_guards.test(-1) |> IO.inspect
