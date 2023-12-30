defmodule EcclesiaDb.Repo.Migrations.AddUsernameToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :citext, null: false
    end
  end
end
