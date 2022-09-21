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
