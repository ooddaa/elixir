# https://hexdocs.pm/elixir/1.13/Process.html

run_query =
  fn query_def ->
    Process.sleep(2000)
    IO.puts("#{query_def} result")
  end

spawn(fn ->
  run_query.("query 1")
end)
# |> IO.inspect()

async_query =
  fn query_def ->
    pid = spawn(fn -> run_query.(query_def) end) # query_def is deep copied

    # https://stackoverflow.com/questions/70102293/transform-process-id-pid-in-elixir-to-tuple-or-string-parse-pid-to-other
    pid_as_string =
      pid
      |> :erlang.pid_to_list()
      |> List.delete_at(0)
      |> List.delete_at(-1)
      |> to_string()

    IO.puts "#{pid_as_string} is #{Process.alive?(pid)}"
  end

Enum.map(1..5, &(async_query.("query #{&1}")))

# Process.info(pid)
