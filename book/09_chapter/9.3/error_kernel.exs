defmodule :error_kernel do
  @moduledoc """
  server explicitly handles errors to keep
  alive as long as possible
  """

  use GenServer

  # CLIENT
  def start() do
    IO.puts("starting error_kernel server")
    GenServer.start(__MODULE__, nil)
  end

  def init(_) do
    {:ok,nil}
  end

  @doc """
  should only send integers
  """
  def square(pid, arg) do
    GenServer.call(pid, {:square, arg})
  end

  # SERVER
  def handle_call({:square, arg}, _, state) do
    try do
      new_state =
        arg * arg
      {:reply, new_state, new_state}
    rescue
      exception ->
        IO.puts("server caught an exception")
        {:reply, {:error, exception }, state}
      # rescue
      #   ArithmeticError ->
      #     IO.puts("server caught an ArithmeticError")
      #     {:reply, {:error }, state}
      catch error ->
        IO.puts("server caught an error")
        IO.inspect(error)
        {:reply, {:error, error }, state}

    end
  end
end
