defmodule Todo.Server.Test do
  use ExUnit.Case, async: true

  setup do
    {:ok, pid} = Todo.Server.start
    %{pid: pid}
  end

  test "test", %{pid: pid} do
    Todo.Server.add_entry(pid, %{date: ~D[2022-09-15], title: "go to park"})
    assert Todo.Server.entries(pid, ~D[2022-09-15], 1000) == [%{date: ~D[2022-09-15], id: 1, title: "go to park"}]
  end

end
