# Global
:global.register_name({:any, "name"}, self())
:global.register_name("lol", self())

# check
:global.whereis_name({:any, "name"})
:global.whereis_name("lol")


# PROCESS GROUPS
# Node1

:pg.start_link(:scope1)
:pg.join(:scope1, :group1, self())

# Node2

:pg.start_link(:scope1)
:pg.which_groups(:scope1) # [:group1]
:pg.get_members(:scope1, :group1)
:pg.join(:scope1, :group1, self())
