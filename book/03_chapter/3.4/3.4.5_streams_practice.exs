defmodule :practice do
  @doc """
  A lines_lengths!/1 that takes a file path and returns
  a list of numbers, with each number representing the
  length of the corresponding line from the file.
  """
  def lines_length!(path) do
    File.stream!(path)
    |> Stream.map(&(String.length(&1)))
    |> Enum.to_list
  end

  @doc """
  A longest_line_length!/1 that returns the length of the
  longest line in a file.
  """
  def longest_line_length!(path) do
    File.stream!(path)
    |> Stream.map(&(String.length(&1)))
    |> Enum.max
  end

  @doc """
  A longest_line!/1 that returns the contents of the longest
  line in a file.
  """
  def longest_line!(path) do
    File.stream!(path)
    |> Enum.max_by(&(String.length(&1)))
  end

  @doc """
  A words_per_line!/1 that returns a list of numbers, with each
  number representing the word count in a file. Hint: to get
  the word count of a line, use length(String.split(line)).
  """
  def words_per_line(path) do
    File.stream!(path)
    |> Stream.map(&(length(String.split(&1))))
    |> Enum.to_list
  end
end

# :practice.lines_length!("./3.4.5_streams_practice.exs") |> IO.inspect()
# :practice.longest_line_length!("./3.4.5_streams_practice.exs") |> IO.inspect()
# :practice.longest_line!("./3.4.5_streams_practice.exs") |> IO.inspect()
# :practice.words_per_line("./3.4.5_streams_practice.exs") |> IO.inspect()
