import Config

# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix assets.deploy` task,
# which you should run after static files are built and
# before starting your production server.
config :ecclesia_db, EcclesiaDbWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  url: [host: "ecclesiadb.org", port: 80],
  check_origin: [
    "//ecclesiadb.org",
    "//www.ecclesiadb.org",
    "//ecclesia-db.gigalixirapp.com/"
  ]

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: EcclesiaDb.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
