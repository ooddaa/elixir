# https://en.wikipedia.org/wiki/Braille_Patterns

defmodule Braille do

  def main do
    # one()
    # draw_top_line(16, 1)
    # draw_top_line(16, 2)
    # draw_top_line(16, 3)
    # draw_top_line(16, 4)

    for i <- 1..10 do
      draw_top_line(i, 4)
    end

    # print(c_circle_sm()<>c_blank()<>c_circle_sm())
  end

  def one do
    range = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
    str = ""

    rv = Enum.reduce(range, str, fn val, acc ->
      acc <> val
    end)

    IO.puts(rv)
  end

  def c_blank, do: " "

  def c_circle_sm do
    cl = "\u288E" # ⢎
    cr = "\u2871" # ⡱
    cl<>cr        # ⢎⡱
  end

  def print stuff do
    IO.puts(stuff)
  end

  def c_line len, height do
    lines = {
      "\u2809", # ⠉
      "\u281B", # ⠛
      "\u283F", # ⠿
      "\u28FF", # ⣿
    }
    Enum.reduce(1..len, "", fn _, acc ->
      acc <> elem(lines, height-1)
    end)
  end

  def draw_top_line len, size do

    case size do
      1 -> rv = c_line(len, 1)
      IO.puts(rv)
      2 -> rv = c_line(len, 2)
      IO.puts(rv)
      3 -> rv = c_line(len, 3)
      IO.puts(rv)
      4 -> rv = c_line(len, 4)
      IO.puts(rv)
      _ -> IO.puts("something wrong!")
    end


  end
end

Braille.main()
