defmodule :messenger do
  def send_message(message) do
    receiver_pid = spawn(&callback/0)
    send(receiver_pid, { :request, self(), message })
  end

  def run_query(query) do
    "#{query} result"
  end

  def send_message2(message) do
    caller = self()
    spawn(fn -> send(caller, {:response, run_query(message)}) end)
  end

  def callback do
    receive do
      { :request, sender_pid, message } ->
        send(sender_pid, {:response, "reply to: #{inspect sender_pid}, message: #{message}"})
      true ->
        {:error, "something wrong"}
    end
    callback()
  end

  def read_mailbox do
    receive do
      {:response, message} ->
        IO.puts("#{message}")
      after
        5000 -> IO.puts("mailbox is empty")
    end

  end

  def test do
    1..2
    # |> Enum.map(&(:messenger.send_message2("lol #{&1}")))
    |> Enum.map(&(:messenger.send_message("lol #{&1}")))
    # |> Enum.map(fn _ -> :messenger.read_mailbox() end)
  end

end


# c("5.2.2_message_passing_2.exs")


# run_query =
#   fn query_def ->
#     Process.sleep(2000)
#     "#{query_def} result"
#   end

# async_query =
#   fn query_def ->
#     caller = self()
#     spawn(fn -> send(caller, {:query_result, run_query.(query_def)}) end)
#   end

# 1..2
# |> Enum.map(&(async_query.("query #{&1}")))
# |> IO.inspect()
