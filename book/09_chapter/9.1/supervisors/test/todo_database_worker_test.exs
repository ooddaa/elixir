# defmodule Todo.Database.Worker.Test do
#   use ExUnit.Case, async: true

#   setup do
#     Todo.System.start_link()
#     :ok
#   end

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
