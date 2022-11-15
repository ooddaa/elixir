defmodule Todo.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [{Todo.System, nil}]
    opts = [strategy: :one_for_one, name: Todo.Hypervisor]
    Supervisor.start_link(children, opts)

    # or just
    # Todo.System.start_link(:lol)
  end
end
