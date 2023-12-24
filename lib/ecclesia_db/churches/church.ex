defmodule EcclesiaDb.Churches.Church do
  use Ecto.Schema
  import Ecto.Changeset

  schema "churches" do
    field :name, :string
    field :description, :string
    field :location, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(church, attrs) do
    church
    |> cast(attrs, [:name, :description, :location])
    |> validate_required([:name, :description, :location])
  end
end
