spawn(fn  ->
  spawn(fn ->
    Process.sleep(1000)
    # gonna print! as perfectly isolated
    IO.puts("1. it's nice to take a nap 😴")
  end)
  raise("error 🙀")
  IO.puts("not gonna print")
end)

spawn(fn  ->
  spawn_link(fn ->
    Process.sleep(1000)
    # gets killed by it's parent ((
    IO.puts("2. it's nice to take a nap 😴 - not gonna print")
  end)
  raise("error 🙀")
  IO.puts("not gonna print")
end)


# TRAP EXIT

spawn(fn ->
  # https://hexdocs.pm/elixir/1.13/Process.html#flag/2
  # https://www.erlang.org/doc/man/erlang.html#process_flag-2
  Process.flag(:trap_exit, true)

  spawn_link(fn -> raise("going down") end)

  receive do
    {:EXIT, _from, reason} ->
      IO.inspect(reason)
    msg ->
      IO.inspect(msg)
      # {:EXIT, #PID<0.102.0>, # Erlang's signature {'EXIT', From, Reason}
      #   {%RuntimeError{message: "going down"},
      #     [
      #       {:elixir_compiler_0, :"-__FILE__/1-fun-4-", 0,
      #       [
      #         file: '8.2.1_linking_processes.ex',
      #         line: 27,
      #         error_info: %{module: Exception}
      #       ]}
      #     ]}}
  end

end)
