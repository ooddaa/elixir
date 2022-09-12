defmodule Geometry do
  def main({:square, a}), do: a*a
  def main({:rectangle, a, b}), do: a*b
  def main({:circle, r}), do: r*r*3.14
  def main(unknown), do: 0

end

Geometry.main({:square, 5}) |> IO.inspect(label: 'square')
Geometry.main({:rectangle, 5, 3}) |> IO.inspect(label: 'rectangle')
Geometry.main({:circle, 5}) |> IO.inspect(label: 'circle')
Geometry.main({:haha, 5}) |> IO.inspect(label: 'unknown')

fun = &Geometry.main/1
fun.({:circle, 123}) |> IO.inspect(label: 'circle-2')
