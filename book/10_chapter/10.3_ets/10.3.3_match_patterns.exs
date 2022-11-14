# https://www.erlang.org/doc/man/ets.html
table = :ets.new(:test, [:public, :named_table, :duplicate_bag])

table |> :ets.insert({ "key1", "anything"})
table |> :ets.insert({ "key2", true})
table |> :ets.insert({ "key2", true})
table |> :ets.insert({ "key2", false})
table |> :ets.insert({ "key3", "anything"})
table |> :ets.insert({ "key4", ["any", "thing"]})
table |> :ets.insert({ %{ key5: "really cool" }, "anything"})

# LOOKUP
# by key
table |> :ets.lookup("key2")
# |> IO.inspect() # [{"key2", true}, {"key2", true}, {"key2", false}]

# MATCH_OBJECT
# returns a tuple[]
# :ets.match_object/2 performs filtering in the ETS memory space, which is more efficient (than row-by-row traversal afther copying to from ETS memory to process' memory by :ets.tab2list/1)
table |> :ets.match_object({ "key2", true })
# |> IO.inspect() # [{"key2", true}, {"key2", true}]
# must be exact
table |> :ets.match_object({ "key2" })
# |> IO.inspect() # []
table |> :ets.match_object({ :_, "anything"})
# |> IO.inspect()
# [
#   {%{key5: "really cool"}, "anything"},
#   {"key1", "anything"},
#   {"key3", "anything"}
# ]

# DELETE
table |> :ets.match_delete({ "key2", true })
# |> IO.inspect() # true

table |> :ets.tab2list()
# |> IO.inspect()
# [
#   {%{key5: "really cool"}, "anything"},
#   {"key1", "anything"},
#   {"key2", false},
#   {"key4", ["any", "thing"]},
#   {"key3", "anything"}
# ]

# https://elixirschool.com/en/lessons/storage/ets
table2 = :ets.new(:test2, [:ordered_set])

table2 |> :ets.insert({ :a, 1, true, ["lol", "foo"]})
table2 |> :ets.insert({ :c, 3, true, ["lol", "foo"]})
table2 |> :ets.insert({ :b, 2, false, ["lol", "foo", "bar"]})

# MATCH
# returns a list[]
table |> :ets.match({ :"$1", true })
# |> IO.inspect() # [["key2"], ["key2"]]
table2 |> :ets.match({ :a, :"$999", :"$1", :_})
# |> IO.inspect() # [[true, 1]]

table2 |> :ets.next(:c) |> IO.inspect()
