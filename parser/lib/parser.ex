defmodule Parser do
  def run(input) do
    parse(input)
  end

  defp parse(input) do
    parser = char(?b)
    parser.(input)
  end

  defp digit, do: satisfy(char(), fn term -> term in ?0..?9 end)
  defp letter, do: satisfy(char(), fn term -> term in ?A..?Z or term in ?a..?z end)
  defp char(expected), do: satisfy(char(), fn term -> term == expected end)

  # combinator
  defp satisfy(parser, predicate) do
    fn input ->
      with {:ok, term, rest} <- parser.(input) do
        if predicate.(term),
          do: {:ok, term, rest},
          else: {:error, "term is rejected: #{to_string(term)}"}
      end
    end
  end

  # combinator returs a parser
  # (input: string) :: {:error, reason } || {:ok, parse_term, rest}
  defp char() do
    fn input ->
      case input do
        "" -> {:error, "unexpected end of input"}
        <<char::utf8, rest::binary>> -> {:ok, char, rest}
      end
    end
  end
end
