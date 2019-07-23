use Mix.Config

config :netguru, ecto_repos: [Netguru.Repo]

import_config "#{Mix.env}.exs"
