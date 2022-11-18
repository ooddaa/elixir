# https://www.erlang.org/doc/man/net_kernel.html#module
# Which nodes that are allowed to communicate with each other is handled by the magic cookie system, see section Distributed Erlang in the Erlang Reference Manual.


:net_kernel.start(:a, %{ name_domain: :shortnames })
:net_kernel.get_state()

%{
  name: :a@oda1,
  name_domain: :shortnames,
  name_type: :static,
  started: :dynamic
}

:net_kernel.stop()

# dynamic node name mode
# gets its name from first node it connects to

:net_kernel.start(:undefined, %{ name_domain: :shortnames })
iex(nonode@nohost)13> :net_kernel.get_state
%{
  name: :undefined,
  name_domain: :shortnames,
  name_type: :dynamic,
  started: :dynamic
}

iex(nonode@nohost)14> Node.connect(:lol@oda1)
true
iex(15JZ0K97PPJ7M@oda1)15>
iex(15JZ0K97PPJ7M@oda1)15> :net_kernel.get_state
%{
  name: :"15JZ0K97PPJ7M@oda1",
  name_domain: :shortnames,
  name_type: :dynamic,
  started: :dynamic
}

# FULLY QUALIFIED NAMES
:net_kernel.start(:undefined, %{ name_domain: :longnames })
Node.connect(:"lol@oda1.local")
true
iex(3ICFYUI6N0CWN@oda1.local)21>

# https://www.erlang.org/doc/reference_manual/distributed.html#distributed-erlang-system
# from Erlang
net_adm:ping(a@oda1). # pong


# HIDDEN
# iex --sname hid --hidden
# connection is not transient -> when connects to NodeA <-> NodeB, NodeB doesnt see it

# 15.7  C Nodes
# A C node is a C program written to act as a hidden node in a distributed Erlang system.

# SECURITY
Node.get_cookie
:HGIXITUANVBGCCMPJGVW # magic cookie 🍪

# default cookie lives here
cd ~
cat .erlang.cookie
HGIXITUANVBGCCMPJGVW

chmod 777 .erlang.cookie
echo "AAAAAAAAAAAAAAAAAAAA" > .erlang.cookie
chmod 400 .erlang.cookie

# hehe now a new node cannot connect to the old node
Node.get_cookie
:AAAAAAAAAAAAAAAAAAAA
iex(hid@oda1)2> Node.connect(:lol@oda1)
false

# :lol@oda1 is changing cookie on ALREADY CONNECTED nodes.
Node.spawn(:a@oda1, fn -> :erlang.set_cookie(:a@oda1, :AAAAAAAAAAAAAAAAAAAA) end)
# after that the hidden node with cookie A can connect to :a@oda1
Node.connect(:a@oda1)
true
# AND :lol@oda1 still communicates with :a@oda1 although they have diff cookies
iex(a@oda1)8> Node.list([:hidden, :visible])
[:oda@oda1, :lol@oda1, :hid@oda1]
