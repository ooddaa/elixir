# node1
:global.set_lock({:a, self()})

# node2 tries to acquire lock, is blocked until it can do so
:global.set_lock({:a, self()})

# node1 releases the lock
:global.del_lock({:a, self()})

# node2 returns true |> lock :a is aquired by Node2

# node1
# acquires lock, does a heavy computation and releases lock when done
# https://www.erlang.org/doc/man/global.html#trans-2
:global.trans({:a, self()}, fn -> IO.puts("lots of data") end)
