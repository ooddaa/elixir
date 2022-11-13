# defmodule Todo.Cache.Test do
#   use ExUnit.Case, async: true

#   test "read empty entry" do
#     Todo.System.start_link()
#     date = ~D[2022-10-03]
#     entry = %{date: date, title: "enjoy"}
#     pid = Todo.Cache.server_process(:lol)
#     :ok = Todo.Server.add_entry(pid, entry)
#     rv = Todo.Server.entries(pid, date)
#     assert Enum.at(rv, 0) == %{date: date, title: "enjoy", id: 1}

#     # cleanup
#     # File.rm!("../data/lol")

#   end

# end
