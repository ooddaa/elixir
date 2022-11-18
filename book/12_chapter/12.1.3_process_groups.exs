# PROCESS GROUPS
# https://www.erlang.org/doc/man/pg.html#module

# Node1

:pg.start_link(:scope1)
:pg.join(:scope1, :group1, self())

# Node2

:pg.start_link(:scope1)
:pg.which_groups(:scope1) # [:group1]
:pg.get_members(:scope1, :group1)
:pg.join(:scope1, :group1, self())


# broadcast to all members of a group :g of scope :s
# :rpc.abcast() takes [Node()]

# all Nodes join :s :g
:pg.start_link(:s)
:pg.join(:s, :g, self()) # using self() everywhere as I'm working from iex
Registry.register(self(), :shell) # :rpc.abcast sends message to (Node, process_name),
# so we must register the process that handles the message locally under common name.
# I cannot use :global.register_name/2 as names are unique globally. therefore
# I must register :shell name locally to be able to abcast to them (processes), having
# received the list of Nodes from the :pg.get_members/2

:pg.get_members(:s, :g)
|> Enum.map(&:erlang.node/1)
|> :rpc.abcast(:shell, "yoyoyo") # everyone who joined group :g in scope :s and has registered
# :shell process locally, that process receives "yoyoyo" message
