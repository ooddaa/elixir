defmodule ServerProcess do
  def start(module) do
    spawn(fn ->
      loop(module.init(), module)
    end)
  end

  # defp loop1(state, module) do
  #   new_state = receive do
  #     message ->
  #       {:ok, result} = module.handle_call(message)
  #       result
  #   end
  #   loop(new_state, module)
  # end

  defp loop(current_state, callback_module) do
    receive do
      {request, caller} ->
        {response, new_state} = callback_module.handle_call(request, current_state)
        send(caller, {:response, response})
        loop(new_state, callback_module)
    end
  end

  def call(server_pid, request) do
    send(server_pid, {request, self()})
    receive do
      {:response, response} -> response
    after
      2_000 -> {:error, :timeout}
    end
  end
end
