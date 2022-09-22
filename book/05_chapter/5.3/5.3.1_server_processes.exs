defmodule :database_server do
  def start, do: spawn(&loop/0)

  defp loop do
    receive do
      {:run_query, caller, query_def} ->
        pid_as_string =
          self()
          |> :erlang.pid_to_list()
          |> to_string()

        send(caller, {:query_result, "result: #{query_def} by #{pid_as_string}"})
    end
    loop()
  end

  def run_async(server_pid, query_def) do
    send(server_pid, {:run_query, self(), query_def})
  end

  def get_result do
    receive do
      {:query_result, result} -> result
    after
      5000 -> {:error, :timeout}
    end
  end

  def create_pool(num \\ 1) do
    Enum.map(1..num, fn _ -> start end)
  end

  def pick_random_servers(servers, num) do
    pool_size = length(servers)
    Enum.map(1..num, fn _ ->
      Enum.at(servers, :rand.uniform(pool_size) - 1)
    end)
  end

  def test(server_number \\ 100, query_number \\ 5) do
    server_number
    |> create_pool()
    |> pick_random_servers(query_number)
    |> Stream.with_index()
    |> Enum.map(fn {pid, index} -> run_async(pid, "query #{index}") end)

  end
end
