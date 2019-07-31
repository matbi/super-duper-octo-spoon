# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :netguru_web,
  namespace: NetguruWeb,
  ecto_repos: [Netguru.Repo]

# Configures the endpoint
config :netguru_web, NetguruWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "E8Etavo74TjT/pAN4skrRfxmLmfLQZ1sX5u0h3ksCsF6CoXrgnybh8IwSnRjQCrI",
  render_errors: [view: NetguruWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NetguruWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :netguru_web, :generators,
  context_app: :netguru

config :netguru_web, NetguruWeb.Guardian,
  allowed_algos: ["HS512"], # optional
  #verify_module: Guardian.JWT,  # optional
  issuer: "NetguruWeb",
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "ednkXywWll1d2svDEpbA39R5kfkc9l96j0+u7A8MgKM+pbwbeDsuYB8MP2WUW1hf", # Insert previously generated secret key!
  serializer: NetguruWeb.Guardian.Serializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
