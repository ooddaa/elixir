# broadcast to a list of Nodes
:rpc.abcast(Node.list, :shell, "yoyoy")


# remote call with returned result
:rpc.call(:lol@oda1, Kernel, :abs, [-22])
