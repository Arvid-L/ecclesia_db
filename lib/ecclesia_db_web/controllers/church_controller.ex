defmodule EcclesiaDbWeb.ChurchController do
  use EcclesiaDbWeb, :controller

  alias EcclesiaDb.Churches
  alias EcclesiaDb.Churches.Church

  def index(conn, _params) do
    churches = Churches.list_churches()
    render(conn, :index, churches: churches)
  end

  def new(conn, _params) do
    changeset = Churches.change_church(%Church{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"church" => church_params}) do
    case Churches.create_church(church_params) do
      {:ok, church} ->
        conn
        |> put_flash(:info, "Church created successfully.")
        |> redirect(to: ~p"/churches/#{church}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    church = Churches.get_church!(id)
    render(conn, :show, church: church)
  end

  def edit(conn, %{"id" => id}) do
    church = Churches.get_church!(id)
    changeset = Churches.change_church(church)
    render(conn, :edit, church: church, changeset: changeset)
  end

  def update(conn, %{"id" => id, "church" => church_params}) do
    church = Churches.get_church!(id)

    case Churches.update_church(church, church_params) do
      {:ok, church} ->
        conn
        |> put_flash(:info, "Church updated successfully.")
        |> redirect(to: ~p"/churches/#{church}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, church: church, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    church = Churches.get_church!(id)
    {:ok, _church} = Churches.delete_church(church)

    conn
    |> put_flash(:info, "Church deleted successfully.")
    |> redirect(to: ~p"/churches")
  end
end
