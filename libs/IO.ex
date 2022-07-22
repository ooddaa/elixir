defmodule IOlibrary do
  def main do
    # https://hexdocs.pm/elixir/1.13/Inspect.Opts.html
    IO.inspect([100, 200, 300, :lol], [
      pretty: true,
      base: :binary,
      limit: 2,
      width: 3,
      syntax_colors: [number: :green, atom: :blue]
      ])

    # keyword brackets may be omitted
    IO.inspect([100, 200, 300, :lol],
      pretty: true,
      base: :binary,
      limit: 2,
      width: 3,
      syntax_colors: [number: :green, atom: :blue]
      )
  end
end

IOlibrary.main()
