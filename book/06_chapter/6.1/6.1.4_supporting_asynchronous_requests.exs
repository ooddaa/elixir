defmodule ServerProcess do
  def start(module) do
    spawn(fn ->
      loop(module.init(), module)
    end)
  end

  defp loop(current_state, callback_module) do
    receive do
      {:call, request, caller} ->
        {response, new_state} = callback_module.handle_call(request, current_state)
        send(caller, {:response, response})
        loop(new_state, callback_module)
      {:cast, request} ->
        new_state = callback_module.handle_cast(request, current_state)
        loop(new_state, callback_module)
    end
  end

  def call(server_pid, request) do
    send(server_pid, {:call, request, self()})
    receive do
      {:response, response} -> response
    after
      2_000 -> {:error, :timeout}
    end
  end

  def cast(server_pid, request) do
    send(server_pid, {:cast, request})
  end
end


defmodule KeyValueStore do
  def start do
    pid = ServerProcess.start(KeyValueStore)

    case Process.whereis(:server_pid) do
      nil -> Process.register(pid, :server_pid)
      pid -> if is_pid(pid) do
        Process.unregister(:server_pid)
        Process.register(pid, :server_pid)
      end

    end
  end

  def init, do: %{}


  # INTERFACE
  def put(key, value) do
    ServerProcess.cast(:server_pid, {:put, key, value})
  end
  def get(key) do
    ServerProcess.call(:server_pid, {:get, key})
  end
  def delete(key) do
    ServerProcess.cast(:server_pid, {:delete, key})
  end

  # SYNC CALL HANDLERS
  def handle_call({:put, key, value}, current_store) do
    {:ok, Map.put(current_store, key, value)}
  end

  def handle_call({:get, key}, current_store) do
    {Map.get(current_store, key), current_store}
  end

  def handle_call({:delete, key}, current_store) do
    {:ok, Map.delete(current_store, key)}
  end

  # ASYNC CAST HANDLERS
  def handle_cast({:put, key, value}, current_store) do
    Map.put(current_store, key, value)
  end

  def handle_cast({:delete, key}, current_store) do
    Map.delete(current_store, key)
  end
end
