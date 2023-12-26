import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ecclesia_db, EcclesiaDb.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ecclesia_db_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  port: 5432

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ecclesia_db, EcclesiaDbWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "zwcQfBLa+gSMeqz3Mk9aJPeTVRlh597xWMtPSNYnId7Vlnjlt2dq0TiI/aQM0Irh",
  server: false

# In test we don't send emails.
config :ecclesia_db, EcclesiaDb.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
