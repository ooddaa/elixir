defmodule KeyValueStore do
  def init(), do: %{}

  def handle_call({:put, key, value}, current_store) do
    {:ok, Map.put(current_store, key, value)}
  end

  def handle_call({:get, key}, current_store) do
    {Map.get(current_store, key), current_store}
  end

  def handle_call({:delete, key}, current_store) do
    {:ok, Map.delete(current_store, key)}
  end
end
