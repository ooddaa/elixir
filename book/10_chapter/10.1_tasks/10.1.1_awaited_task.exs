# https://hexdocs.pm/elixir/Task.html
# The most common use case for tasks is to convert sequential code into concurrent code by computing a value asynchronously:

long_job =
  fn ->
    Process.sleep(2000)
    :some_result
  end

# task =
#   Task.async(long_job)
#   |> IO.inspect

# %Task{
#   mfa: {:erlang, :apply, 2},
#   owner: #PID<0.94.0>,
#   pid: #PID<0.97.0>,
#   ref: #Reference<0.1603504889.1571880961.129181>
# }

# Task.await(task) |> IO.inspect


run_query =
  fn query_def ->
    Process.sleep(2000)
    "#{query_def} result"
  end

queries =
  1..3
  # |> Enum.map(&(Task.async(run_query.(&1)))) # <- my initial mistake. Taks.async takes a lambda
  |> Enum.map(&(Task.async(fn -> run_query.(&1) end))) # has all-or-nothing semantics. The crash of a single task takes down all other tasks as well as the starter process.
  |> Enum.map(&Task.await/1)
  |> IO.inspect()
