# node1 and node2 connected

# node2
:global.register_name("lol", self())

# node1
Process.monitor(:global.whereis_name("lol"))

# now when I kill node2, node1 receives (flush())
# {:DOWN, #Reference<0.3681650262.3247702018.139319>, :process, #PID<11933.112.0>,
#  :killed}

# if I just quit node2, node1 receives
# {:DOWN, #Reference<0.3681650262.3247702018.139404>, :process, #PID<11933.112.0>,
#  :noconnection}
