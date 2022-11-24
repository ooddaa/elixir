defmodule Todo.System do
  use Supervisor

  # https://hexdocs.pm/elixir/Supervisor.html#module-module-based-supervisors
  # MODULE BASED SUPERVISOR
  def start_link(_) do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    Supervisor.init([
      # Todo.ProcessRegistry, # provides child_spec
      Todo.Database, # provides child_spec
      Todo.Cache, # provides GenServer child_spec
      # Todo.Metrics,
      Todo.Web
      ], strategy: :one_for_one)
  end
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
