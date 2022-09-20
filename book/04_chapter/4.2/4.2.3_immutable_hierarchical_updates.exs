# https://hexdocs.pm/elixir/Access.html#content
# https://hexdocs.pm/elixir/Kernel.html#put_in/2
todos = %{
  :monday => %{ "a" => 1, "b" => 2 },
  :tuesday => %{ "d" => 3 },
}

todo_list = [
  %{ task: "sleep", day: :moday, value: 1 },
  %{ task: "work", day: :tuesday, value: 10 },
]

# GET_IN
# todos
# |> get_in([:monday, "a"])
# |> IO.inspect() # 1

# access with filter
# todo_list
# |> get_in([Access.filter(&(&1.value > 1)), :task])
# |> IO.inspect() # ["work"]

#PUT_IN
# put_in(todos[:tuesday]["c"], 4)
# |> IO.inspect() # %{monday: %{"a" => 1, "b" => 2}, tuesday: %{"c" => 4, "d" => 3}}

# put_in(todos, [:tuesday, "c"], 4)
# |> IO.inspect() # %{monday: %{"a" => 1, "b" => 2}, tuesday: %{"c" => 4, "d" => 3}}

# put_in(todos.tuesday["c"], 4) # (KeyError) key :c not found in: %{"d" => 3}
# |> IO.inspect() # %{monday: %{"a" => 1, "b" => 2}, tuesday: %{"c" => 4, "d" => 3}}

# put_in(todos[:tuesday].c, 4) # (KeyError) key :c not found in: %{"d" => 3}

# Structs only allow struct.key access


# UPDATE_IN
# https://hexdocs.pm/elixir/Kernel.html#update_in/3
# todos
# |> update_in([:monday, "a"], &(&1 + 999))
# |> IO.inspect() # %{monday: %{"a" => 1000, "b" => 2}, tuesday: %{"d" => 3}}

# Access.all()
# todo_list
# |> update_in([Access.all(), :task], &String.upcase/1)
# |> IO.inspect() # [%{day: :moday, task: "SLEEP"}, %{day: :tuesday, task: "WORK"}]


# GET_AND_UPDATE
# https://hexdocs.pm/elixir/Access.html#get_and_update/3

# Access.get_and_update(todos.monday, "a", fn current_val ->
#   {current_val, current_val + 999}
# end)
# |> IO.inspect() # {1, %{"a" => 1000, "b" => 2}}

# Access.get_and_update(todos, [:monday, "a"], fn current_val ->
#   {current_val, current_val + 999}
# end)
# |> IO.inspect() # (ArithmeticError) bad argument in arithmetic expression

# todos
# |> get_and_update_in([:monday, "a"], fn current_val ->
#   {current_val, current_val + 999}
# end)
# |> IO.inspect() # {1, %{monday: %{"a" => 1000, "b" => 2}, tuesday: %{"d" => 3}}}


# POP
# todos
# |> pop_in([:monday, "a"])
# # |> IO.inspect() # {1, %{monday: %{"b" => 2}, tuesday: %{"d" => 3}}}
