defmodule EcclesiaDb.ChurchesTest do
  use EcclesiaDb.DataCase

  alias EcclesiaDb.Churches

  describe "churches" do
    alias EcclesiaDb.Churches.Church

    import EcclesiaDb.ChurchesFixtures

    @invalid_attrs %{name: nil, description: nil, location: nil}

    test "list_churches/0 returns all churches" do
      church = church_fixture()
      assert Churches.list_churches() == [church]
    end

    test "get_church!/1 returns the church with given id" do
      church = church_fixture()
      assert Churches.get_church!(church.id) == church
    end

    test "create_church/1 with valid data creates a church" do
      valid_attrs = %{
        name: "some name",
        description: "some description",
        location: "some location"
      }

      assert {:ok, %Church{} = church} = Churches.create_church(valid_attrs)
      assert church.name == "some name"
      assert church.description == "some description"
      assert church.location == "some location"
    end

    test "create_church/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Churches.create_church(@invalid_attrs)
    end

    test "update_church/2 with valid data updates the church" do
      church = church_fixture()

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        location: "some updated location"
      }

      assert {:ok, %Church{} = church} = Churches.update_church(church, update_attrs)
      assert church.name == "some updated name"
      assert church.description == "some updated description"
      assert church.location == "some updated location"
    end

    test "update_church/2 with invalid data returns error changeset" do
      church = church_fixture()
      assert {:error, %Ecto.Changeset{}} = Churches.update_church(church, @invalid_attrs)
      assert church == Churches.get_church!(church.id)
    end

    test "delete_church/1 deletes the church" do
      church = church_fixture()
      assert {:ok, %Church{}} = Churches.delete_church(church)
      assert_raise Ecto.NoResultsError, fn -> Churches.get_church!(church.id) end
    end

    test "change_church/1 returns a church changeset" do
      church = church_fixture()
      assert %Ecto.Changeset{} = Churches.change_church(church)
    end
  end
end
