defmodule Todo.System do
  use Supervisor

  # https://hexdocs.pm/elixir/Supervisor.html#module-module-based-supervisors
  # MODULE BASED SUPERVISOR
  def start_link(_) do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    Supervisor.init([
      Todo.ProcessRegistry, # provides child_spec
      Todo.Database, # provides child_spec
      Todo.Cache, # provides GenServer child_spec
      # Todo.Metrics,
      ], strategy: :one_for_one)
  end

  # def init(_) do
  #   Supervisor.init([
  #     Todo.ProcessRegistry,
  #     # or define child_spec(_) in Todo.Database
  #     %{
  #       id: Todo.Database,
  #       start: { Todo.Database, :start_link, [] },
  #       type: :supervisor,
  #     },
  #     Todo.Cache,
  #     ], strategy: :one_for_one)
  # end
end

# defmodule Todo.System do
#   def start_link do
#     Supervisor.start_link(
#       [
#         Todo.ProcessRegistry,
#         Todo.Database,
#         Todo.Cache
#       ],
#       strategy: :one_for_one
#     )
#   end
# end
