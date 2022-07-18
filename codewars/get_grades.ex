# https://www.codewars.com/kata/55cbd4ba903825f7970000f5/train/elixir

# Complete the function so that it finds the average of the three scores passed to it and returns the letter value associated with that grade.

# Numerical Score	Letter Grade
# 90 <= score <= 100	'A'
# 80 <= score < 90	'B'
# 70 <= score < 80	'C'
# 60 <= score < 70	'D'
# 0 <= score < 60	'F'
# Tested values are all between 0 and 100. Theres is no need to check for negative values or values greater than 100.

defmodule GetGrade do
  def get_grade(a, b, c) do
    # score = Enum.reduce([a, b, c], 0, fn val, acc -> acc + val end) / 3
    score = (a + b + c) / 3
    rv = cond do
      # 90 <= score and score <= 100 -> "A"
      # 80 <= score and score <= 90 -> "B"
      # 70 <= score and score <= 80 -> "C"
      # 60 <= score and score <= 70 -> "D"
      # 0 <= score and score <= 60 -> "F"
      score >= 90 -> "A"
      score >= 80 -> "B"
      score >= 70 -> "C"
      score >= 60 -> "D"
      true -> "F"
    end
    IO.inspect(rv)
  end

  def get_grade2(a, b, c) do
    rv = case (a + b + c) / 3 do
      score when score >= 90 -> "A"
      score when score >= 80 -> "B"
      score when score >= 70 -> "C"
      score when score >= 60 -> "D"
      true -> "F"
    end
    IO.inspect(rv)
  end

  def get_grade3(a, b, c) do
    score((a + b + c) / 3)
  end

  def score(s) when s >= 90, do: "A"
  def score(s) when s >= 80, do: "B"
  def score(s) when s >= 70, do: "C"
  def score(s) when s >= 60, do: "D"
  def score(_), do: "F"

end

GetGrade.get_grade2(100,99,98)
