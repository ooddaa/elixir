defmodule Todo.MixProject do
  use Mix.Project

  def project do
    [
      app: :todo,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # releases: [
      #   foo: [
      #     version: "0.1.0",
      #     applications: [todo: :permanent]
      #   ]
      # ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Todo.Application, []},
      # env: [:some_key, []] # Application.fetch_env!(:todo, :some_key)
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_test_watch, "~> 1.0", only: :dev},
      {:poolboy, "~> 1.5"},
      {:plug_cowboy, "~> 1.0"},
      {:plug, "~> 1.4"},
      {:distillery, "~> 2.1.1"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  ]
  end
end
