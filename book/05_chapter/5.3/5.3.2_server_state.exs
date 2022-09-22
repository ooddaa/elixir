defmodule :server do
  def start do
    spawn(fn ->
      connection = :rand.uniform(1000)
      loop(connection)
    end
      )
  end

  def run_query(value) do
    "query value: #{value}"
  end

  def loop(connection) do
    receive do
      {:run_query, caller, value} ->
        result = run_query(value)
        send(caller, {:query_result, "Connection: #{connection}", result})
    end
    loop(connection)
  end

  def run_async(server_pid, query_def) do
    send(server_pid, {:run_query, self(), query_def})
  end

  def get_result do
    receive do
      { :query_result, connection, result } -> { connection, result }
    after
      5000 -> {:error, :timeout}
    end
  end

  def create_pool(num \\ 1) do
    Enum.map(1..num, fn _ -> start end)
  end

  def test do
    5
    |> create_pool()
    |> Stream.with_index()
    |> Enum.map(fn { server, query } ->
      run_async(server, query)
    end)
  end
end
