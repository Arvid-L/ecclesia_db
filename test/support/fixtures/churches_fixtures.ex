defmodule EcclesiaDb.ChurchesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EcclesiaDb.Churches` context.
  """

  @doc """
  Generate a church.
  """
  def church_fixture(attrs \\ %{}) do
    {:ok, church} =
      attrs
      |> Enum.into(%{
        description: "some description",
        location: "some location",
        name: "some name"
      })
      |> EcclesiaDb.Churches.create_church()

    church
  end
end
