use Mix.Config

# Configure your database
config :netguru, Netguru.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "netguru_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
