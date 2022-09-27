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

defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def start do
    pid = ServerProcess.start(TodoList)

    case Process.whereis(:server_pid) do
      nil -> Process.register(pid, :server_pid)
      pid -> if is_pid(pid) do
        Process.unregister(:server_pid)
        Process.register(pid, :server_pid)
      end

    end
  end

  def init, do:  %TodoList{}

  # INTERFACE
  def add_entry(entry) do
    ServerProcess.cast(:server_pid, {:add_entry, entry})
  end

  def entries() do
    ServerProcess.call(:server_pid, {:entries})
  end

  def update_entry(id, updater) do
    ServerProcess.call(:server_pid, {:update_entry, id, updater})
  end

  def delete_entry(entry_id) do
    ServerProcess.cast(:server_pid, {:delete_entry, entry_id})
  end

  # SYNC CALL HANDLERS
  def handle_call({:entries}, todo_list) do
    {todo_list, todo_list}
  end

  def handle_call({:update_entry, entry_id, updater_fun}, todo_list) do
    new_todo_list = case Map.fetch(todo_list.entries, entry_id) do
      :error -> todo_list
      { :ok, entry } ->
        new_entries = Map.put(todo_list.entries, entry_id, updater_fun.(entry))
        %TodoList{ todo_list | entries: new_entries }
    end
    {:ok, new_todo_list}
  end

  # ASYNC CAST HANDLERS
  def handle_cast({:add_entry, entry}, todo_list) do
    entry = Map.put(entry, :id, todo_list.auto_id)
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  def handle_cast({:delete_entry, entry_id}, todo_list) do
    %TodoList{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
  end

end
