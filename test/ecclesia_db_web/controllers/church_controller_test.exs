defmodule EcclesiaDbWeb.ChurchControllerTest do
  use EcclesiaDbWeb.ConnCase

  import EcclesiaDb.ChurchesFixtures

  @create_attrs %{name: "some name", description: "some description", location: "some location"}
  @update_attrs %{name: "some updated name", description: "some updated description", location: "some updated location"}
  @invalid_attrs %{name: nil, description: nil, location: nil}

  describe "index" do
    test "lists all churches", %{conn: conn} do
      conn = get(conn, ~p"/churches")
      assert html_response(conn, 200) =~ "Listing Churches"
    end
  end

  describe "new church" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/churches/new")
      assert html_response(conn, 200) =~ "New Church"
    end
  end

  describe "create church" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/churches", church: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/churches/#{id}"

      conn = get(conn, ~p"/churches/#{id}")
      assert html_response(conn, 200) =~ "Church #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/churches", church: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Church"
    end
  end

  describe "edit church" do
    setup [:create_church]

    test "renders form for editing chosen church", %{conn: conn, church: church} do
      conn = get(conn, ~p"/churches/#{church}/edit")
      assert html_response(conn, 200) =~ "Edit Church"
    end
  end

  describe "update church" do
    setup [:create_church]

    test "redirects when data is valid", %{conn: conn, church: church} do
      conn = put(conn, ~p"/churches/#{church}", church: @update_attrs)
      assert redirected_to(conn) == ~p"/churches/#{church}"

      conn = get(conn, ~p"/churches/#{church}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, church: church} do
      conn = put(conn, ~p"/churches/#{church}", church: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Church"
    end
  end

  describe "delete church" do
    setup [:create_church]

    test "deletes chosen church", %{conn: conn, church: church} do
      conn = delete(conn, ~p"/churches/#{church}")
      assert redirected_to(conn) == ~p"/churches"

      assert_error_sent 404, fn ->
        get(conn, ~p"/churches/#{church}")
      end
    end
  end

  defp create_church(_) do
    church = church_fixture()
    %{church: church}
  end
end
