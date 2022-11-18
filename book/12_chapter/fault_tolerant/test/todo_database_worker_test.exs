# defmodule Todo.Database.Worker.Test do
#   use ExUnit.Case

#   setup do
#     case Todo.System.start_link() do
#       {:error, {:already_started, pid }} -> %{pid: pid}
#       {:ok, pid} -> %{pid: pid}
#     end

#   end

#   # test "count_children", %{pid: pid} do
#   #   rv = Supervisor.count_children(pid)
#   #   assert rv == %{active: 3, specs: 3, supervisors: 2, workers: 1}
#   # end

#   test "kill one worker" do
#     [{worker_pid, _val}] = Registry.lookup(
#       Todo.ProcessRegistry,
#       {Todo.Database.Worker, 3}
#     )
#     IO.puts(inspect(worker_pid))
#     # kill it
#     Process.exit(worker_pid, :kill)

#     # and it gets restarted
#     [{worker_pid2, _val}] = Registry.lookup(
#       Todo.ProcessRegistry,
#       {Todo.Database.Worker, 3}
#     )
#     assert is_pid(worker_pid2) == true
#     assert worker_pid == worker_pid2 # restarts the process, saving its PID!!?
#     # assert worker_pid != worker_pid2 # restarts the process, saving its PID!!?
#   end
# end
