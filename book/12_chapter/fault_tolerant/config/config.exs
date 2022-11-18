import Config

config :todo, http_port: 5454

import_config "#{config_env()}.exs"
