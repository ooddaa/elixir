# https://hexdocs.pm/elixir/1.13/Node.html
# iex --sname node1@nodeServer1
# iex --sname node2@nodeServer1
# node()
# n2 = node2@nodeServer1
# import Node
# connect(:node2@nodeServer1) / disconnect
# list()
# spawn(:node2@nodeServer1, lambda)
# alive?
# get_cookie n2
# ping n2 // :pong | :pang

# spawn(o2, fn -> send(caller, {:response, 1+2}) end)
# flush()

defmodule Yo do
  import IO
  def hello do
    puts "hello from #{node()}"
  end
end

# from :oda1@oda1
# Node.connect(:oda2@oda1)
# Node.spawn(:oda2@oda1, Yo, :hello, [])
# send({:shell, :oda2@oda1}, "heh1")
# flush()

# HOW DO I OBTAIN PID OF A PROCESS RUNNING ON ANOTHER NODE?
# :global.register_name({:name, "yo"}, pid)
# :global.whereis_name({:name, "yo"})
