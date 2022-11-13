defmodule :system do
# alias Task.Supervisor
  use Supervisor

  # DIRECTLY STARTED SUPERVISOR
  # def start_link do
  #   Supervisor.start_link([
  #     :data_agent
  #   ], strategy: :one_for_one)
  # end

  # def init(_) do
  #   :ok
  # end

  # MODULE-BASED SUPERVISOR
  def start_link do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    Supervisor.init([
      :data_agent
    ], strategy: :one_for_one)
  end

end

defmodule :data_agent do
  use Agent

  # def start_link, do: Agent.start_link(fn -> %{a: 1} end)
  def start_link(_), do: Agent.start_link(fn -> %{a: 1} end, name: __MODULE__)

  # def child_spec(_) do
  #   %{
  #     id: __MODULE__, # set up id for multiple restarts in supervision tree
  #     start: {__MODULE__, :start_link, []},
  #     type: :supervisor,
  #   }
  # end

  def get(agent), do: Agent.get(agent, fn state -> state end)
  def get(agent, key), do: Agent.get(agent, fn state -> state[key] end)

  def update(agent, update_fn) do
    Agent.update(agent, fn state ->
      update_fn.(state)
    end)
  end
end
