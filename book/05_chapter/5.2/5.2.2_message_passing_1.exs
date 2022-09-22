defmodule :receiver do
  def callback do
      receive do
        {:message, payload} ->
          IO.puts("received: #{payload}")
          callback()
        {:error, payload} ->
          IO.puts("error: #{payload}")
          callback()
      # after
      #   5000 -> IO.puts("can't wait anymore")
      end
    end
end


# c("5.2.2_message_passing.exs") # [:receiver]
# pid = spawn(&:receiver.callback/0) # #PID<0.116.0>
# Process.exit(pid, "enough is enough") # true
# Process.alive?(pid) # false
