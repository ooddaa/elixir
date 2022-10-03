test = fn fun ->
  target_pid = spawn(fn ->
    Process.sleep(1000)
    fun.()
  end)

  Process.monitor(target_pid)

  receive do
    msg -> IO.inspect(msg)
  end
end

# test.(fn -> end) # {:DOWN, #Reference<0.1581538388.2609381380.155011>, :process, #PID<0.97.0>, :normal}

# test.(fn -> raise("eeeerrrroooorrr") end)
# {:DOWN, #Reference<0.2303423958.4220256261.20151>, :process, #PID<0.98.0>,
# {%RuntimeError{message: "eeeerrrroooorrr"},
#  [
#    {:elixir_compiler_0, :"-__FILE__/1-fun-3-", 0,
#     [file: '8.2.2_monitors.ex', line: 16, error_info: %{module: Exception}]}
#  ]}}

# test.(fn -> throw("throoooown") end)
# {:DOWN, #Reference<0.1450725890.2610167814.146949>, :process, #PID<0.97.0>,
#  {{:nocatch, "throoooown"},
#   [
#     {:elixir_compiler_0, :"-__FILE__/1-fun-2-", 0,
#      [file: '8.2.2_monitors.ex', line: 24]}
#   ]}}

# test.(fn -> exit("hasta la vista") end)
# {:DOWN, #Reference<0.2503318114.1268252679.29014>, :process, #PID<0.97.0>,
#  "hasta la vista"}
