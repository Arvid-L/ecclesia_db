defmodule EcclesiaDb.Churches do
  @moduledoc """
  The Churches context.
  """

  import Ecto.Query, warn: false
  alias EcclesiaDb.Repo

  alias EcclesiaDb.Churches.Church

  @doc """
  Returns the list of churches.

  ## Examples

      iex> list_churches()
      [%Church{}, ...]

  """
  def list_churches do
    Repo.all(Church)
  end

  @doc """
  Gets a single church.

  Raises `Ecto.NoResultsError` if the Church does not exist.

  ## Examples

      iex> get_church!(123)
      %Church{}

      iex> get_church!(456)
      ** (Ecto.NoResultsError)

  """
  def get_church!(id), do: Repo.get!(Church, id)

  @doc """
  Creates a church.

  ## Examples

      iex> create_church(%{field: value})
      {:ok, %Church{}}

      iex> create_church(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_church(attrs \\ %{}) do
    %Church{}
    |> Church.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a church.

  ## Examples

      iex> update_church(church, %{field: new_value})
      {:ok, %Church{}}

      iex> update_church(church, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_church(%Church{} = church, attrs) do
    church
    |> Church.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a church.

  ## Examples

      iex> delete_church(church)
      {:ok, %Church{}}

      iex> delete_church(church)
      {:error, %Ecto.Changeset{}}

  """
  def delete_church(%Church{} = church) do
    Repo.delete(church)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking church changes.

  ## Examples

      iex> change_church(church)
      %Ecto.Changeset{data: %Church{}}

  """
  def change_church(%Church{} = church, attrs \\ %{}) do
    Church.changeset(church, attrs)
  end
end
