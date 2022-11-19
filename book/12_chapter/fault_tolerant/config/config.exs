import Config

config :todo, :database, pool_size: 3, folder: "./persist"
config :todo, http_port: 5454
config :todo, todo_item_expiry: :timer.minutes(1)

import_config "#{config_env()}.exs"
