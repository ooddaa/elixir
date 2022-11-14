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

# mix run -e "Bench.run(:ekv)"
# 3_304_229 operations/sec
# 3_282_562 operations/sec

# mix run -e "Bench.run(:ekv, concurrency: 1000, num_updates: 100)"
# 16_846_231 operations/sec
# 15_727_343 operations/sec
