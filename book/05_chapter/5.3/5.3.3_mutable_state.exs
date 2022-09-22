defmodule :server do
  def start do
    spawn(fn -> loop(0) end)
  end

  def loop(current_value) do
    new_current_value = receive do
      {:value, caller} ->
        send(caller, {:value, current_value})
        current_value
      {:add, value} -> current_value + value
      {:sub, value} -> current_value - value
      {:mult, value} -> current_value * value
      {:div, value} -> case value == 0 do
        true -> current_value
        false -> current_value / value
      end
      # invalid_case -> {}
    end
    loop(new_current_value)
  end

  def add(server_pid, value), do: send(server_pid, {:add, value})
  def sub(server_pid, value), do: send(server_pid, {:sub, value})
  def mult(server_pid, value), do: send(server_pid, {:mult, value})
  def div(server_pid, value), do: send(server_pid, {:div, value})

  def value(server_pid) do
    send(server_pid, {:value, self()})
    receive do
      { :value, value } -> value
    after
      5000 -> {:error, :timeout}
    end
  end
end
