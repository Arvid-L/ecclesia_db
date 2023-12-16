defmodule EcclesiaDb.Repo do
  use Ecto.Repo,
    otp_app: :ecclesia_db,
    adapter: Ecto.Adapters.Postgres
end
