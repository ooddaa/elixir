defmodule Todo.Cache.Test do
  use ExUnit.Case, async: true

  setup do
    {:ok, pid} = Todo.Cache.start
    %{pid: pid}
  end

  test "test", %{pid: pid} do
    first_server = Todo.Cache.server_process(pid, "a")
    second_server = Todo.Cache.server_process(pid, "b")

    assert first_server != second_server

    Todo.Server.add_entry(first_server, %{date: ~D[2022-09-30], title: "Amari"})

    assert [%{date: ~D[2022-09-30], title: "Amari"}] = Todo.Server.entries(first_server, ~D[2022-09-30])
    assert [] = Todo.Server.entries(second_server, ~D[2022-09-30])
  end

end
