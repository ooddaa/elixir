defmodule :ekv do
  use GenServer

  def start_link(), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def init(_) do
    { :ok, :ets.new(__MODULE__, [:public, :named_table, write_concurrency: true ]) }
  end

  def info() do
    IO.inspect(:ets.info(__MODULE__))
  end

  def put(key, val) do
    :ets.insert(__MODULE__, { key, val })
  end

  def get(key) do
    case :ets.lookup(__MODULE__, key) do
      [{ ^key, val }] -> val
      [] -> nil
    end
  end
end
# defmodule :ekv do
#   use GenServer

#   def start_link(table), do: GenServer.start_link(__MODULE__, table, name: __MODULE__)

#   def init(table) do
#     { :ok, :ets.new(table, [:public, :named_table]) }
#   end

#   def info((table)) do
#     IO.inspect(:ets.info(table))
#   end

#   def put(table, val) do
#     table
#     |> :ets.insert(val)
#   end

#   def get(table, key) do
#     table
#     |> :ets.lookup(key)
#   end
# end
