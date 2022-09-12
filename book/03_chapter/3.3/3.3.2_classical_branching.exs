if 1 === 1 do
  IO.puts("yas 1")
else
  IO.puts("nope")
end

if 1 === 1, do: IO.puts("yas 2"), else: IO.puts("nope")

defmodule :classical_branching do
  def max(a,b) do
    if a > b, do: a, else: b
  end

  def max_unless(a,b) do
    unless a > b, do: b, else: a
  end

  def max_condition(a,b) do
    cond do
      a > b -> a
      true -> b
    end
  end

  def max_case(a,b) do
    case a > b do
      true -> a
      false -> b
    end
  end

end

:classical_branching.max(1,4)
# |> IO.inspect(label: 'max == 4')

:classical_branching.max_unless(1,4)
# |> IO.inspect(label: 'max_unless == 4')

:classical_branching.max_condition(1,4)
# |> IO.inspect(label: 'max_condition == 4')

:classical_branching.max_case(1,4)
# |> IO.inspect(label: 'max_case == 4')
