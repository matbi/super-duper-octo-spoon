use Mix.Config

# Configure your database
config :netguru, Netguru.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "netguru_dev",
  hostname: "localhost",
  pool_size: 10
