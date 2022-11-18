# elr
net_adm:localhost().
:net_adm.localhost()


# hows hidden node names??
:net_adm.names
{:ok, [{'oda', 49228}, {'a', 49233}, {'lol', 49245}, {'hid', 49325}]}
iex(lol@oda1)25> Node.list([:hidden])
[]
