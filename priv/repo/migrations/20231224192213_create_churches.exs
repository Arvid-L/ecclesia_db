defmodule EcclesiaDb.Repo.Migrations.CreateChurches do
  use Ecto.Migration

  def change do
    create table(:churches) do
      add :name, :string
      add :description, :string
      add :location, :string

      timestamps(type: :utc_datetime)
    end
  end
end
