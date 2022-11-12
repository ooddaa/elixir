defmodule :data_agent do
  use Agent

  def start_link, do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def get(agent, key), do: Agent.get(agent, fn state -> state[key] end)

  def update(agent, update_fn) do
    Agent.update(agent, fn state ->
      update_fn(state)
    end)
  end
end
