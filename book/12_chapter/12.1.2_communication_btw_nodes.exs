Node.spawn(:hid@oda1, fn -> IO.puts("hi from #{node}") end)
#PID<12839.133.0>
hi from hid@oda1

# hmmm???
iex(a@oda1)15> Node.spawn(:hid@oda1, IO, :puts, ["hi from #{node}"])
hi from a@oda1
#PID<12839.134.0>
