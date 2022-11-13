table = :ets.new(:test, [:public, :named_table])

table |> :ets.insert({ "key1", "anything"})
table |> :ets.insert({ "key2", ["any", "thing"]})
table |> :ets.insert({ %{ key3: "really cool" }, "anything"})

table |> :ets.lookup("key1") |> IO.inspect()
table |> :ets.lookup("key2") |> IO.inspect()
table |> :ets.lookup(%{ key3: "really cool" }) |> IO.inspect()

table |> :ets.match_object({ :_, "anything"}) |> IO.inspect()

# https://www.erlang.org/doc/man/ets.html#give_away-3
# can :ets.give_away(table, new_owner_pid, { "message" })
# new_owner must handle_info(:"ETS_TRANSFER", table_ref, sender_pid, msg_data)
# 19:55:18.201 [error] Agent.Server #PID<0.114.0> received unexpected message in handle_info/2: {:"ETS-TRANSFER", #Reference<0.4226194934.3156344835.231865>, #PID<0.106.0>,
# handy to give_away table when GenServer terminates to persist state
