# https://en.wikipedia.org/wiki/Braille_Patterns

defmodule MyError do
  defexception message: ("aaaa")
end

defmodule Braille do
  @moduledoc """
  Draws pictures with Braille code symbols
  """
  import Enum
  import IO

  def main do


    top_line = fn len, height ->
      top_lines = {
        "\u2809", # ⠉
        "\u281B", # ⠛
        "\u283F", # ⠿
        "\u28FF", # ⣿
      }
      reduce(1..len, "", fn _, acc ->
        acc <> elem(top_lines, height-1)
      end)
    end

    bottom_line = fn len, height ->
      bottom_lines = {
        "\u28C0", # ⣀
        "\u28E4", # ⣤
        "\u28F6", # ⣶
        "\u28FF", # ⣿
      }
      reduce(1..len, "", fn _, acc ->
        acc <> elem(bottom_lines, height-1)
      end)
    end

    # for i <- 1..4 do
    #   for j <- 1..10 do
    #     draw_line(bottom_line, j, i)
    #   end
    # end
    # for j <- 1..10 do
    #   draw_line(bottom_line, 20, 4)
    # end

    # print(c_circle_sm()<>c_blank()<>c_circle_sm())

    rect = fn width, height, line_type ->
      rv = reduce(1..height, "", fn _, acc ->
        acc <> line_type.(width, 4) <> "\n"
      end)
    end

    square = fn height ->
      # I dunno height*2-1 kinda looks more squarish
      rect.(height*2-1, height, bottom_line)
    end

    # print(rect.(10, 5, bottom_line))

    print(square.(10))

  end

  @doc """
  Hz no idea what this is for
  """
  @spec one :: none
  def one do
    range = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
    str = ""

    rv = reduce(range, str, fn val, acc ->
      acc <> val
    end)

    puts(rv)
  end

  @doc """
  Prints a whitespace
  """
  def c_blank, do: " "

  @doc """
  Returns a ⢎⡱
  """
  @spec c_circle_sm :: string
  def c_circle_sm do
    cl = "\u288E" # ⢎
    cr = "\u2871" # ⡱
    cl<>cr        # ⢎⡱
  end

  @doc """
  Just prints anything to the stdout
  """
  @spec print(any) :: none
  def print stuff do
    puts(stuff)
  end

  @doc """
  Draws a line of a specific type (1st arg) equals to length (2nd arg) and height (3rd arg)
  """
  @spec draw_line(function, number, number) :: none
  def draw_line fun, len, size do
    case member?([1,2,3,4], size) do
      true -> rv = fun.(len, size)
        puts(rv)
      false -> raise MyError
      # false -> raise("Braille::draw_line: size is of range 1..4")
    end
  end


end

Braille.main()
