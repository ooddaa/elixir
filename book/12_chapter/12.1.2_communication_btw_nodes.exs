Node.spawn(:hid@oda1, fn -> IO.puts("hi from #{node}") end)
#PID<12839.133.0>
hi from hid@oda1

# hmmm???
iex(a@oda1)15> Node.spawn(:hid@oda1, IO, :puts, ["hi from #{node}"])
hi from a@oda1
#PID<12839.134.0>

# send can be used to send message to a Process on another Node
Process.register(self(), :lol) # Node2
send({:lol, :node2@oda1}, "lets go") # Node1
flush() # Node2 gets the message "lets go"
