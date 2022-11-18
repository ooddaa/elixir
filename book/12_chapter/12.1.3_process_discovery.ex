# Global
:global.register_name({:any, "name"}, self())
:global.register_name("lol", self())

# check
:global.whereis_name({:any, "name"})
:global.whereis_name("lol")
