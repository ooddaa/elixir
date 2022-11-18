# the process will provide to-do server pids.
# You give it a name, and it gives you the corresponding server process.
defmodule Todo.Cache do
  def start_link do
    IO.puts("Starting supervised todo cache")
    DynamicSupervisor.start_link(name: __MODULE__, strategy: :one_for_one)
  end

  def server_process(name) do
    existing_server(name) || new_server(name)
  end

  defp existing_server(name) do
    Todo.Server.whereis(name)
  end

  defp new_server(name) do
    case DynamicSupervisor.start_child(__MODULE__, {Todo.Server, name}) do
      {:error, {:already_started, pid}} -> pid
      {:ok, pid} -> pid
    end
  end

  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :supervisor
    }
  end
end
