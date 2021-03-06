defmodule Test.Pharmacies do
  @moduledoc """
  The Pharmacies context.
  """

  import Ecto.Query, warn: false
  alias Test.Repo

  alias Test.Pharmacies.Pharmacy

  @doc """
  Gets a single pharmacy.

  Raises `Ecto.NoResultsError` if the Pharmacy does not exist.

  ## Examples

      iex> get_pharmacy!(123)
      %Pharmacy{}

      iex> get_pharmacy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pharmacy!(id), do: Repo.get!(Pharmacy, id)

  @doc """
  Gets a single pharmacy with the given attributes.

  Returns `nil` if no matching pharmacy is found.

  ## Examples

      iex> get_pharmacy_by(%{name: "A Pharmacy"})
      %Pharmacy{name: "Fred"}

      iex> get_pharmacy_by(%{name: "Non-existant"})
      nil

  """
  def get_pharmacy_by(attrs) do
    Repo.get_by(Pharmacy, attrs)
  end

  @doc """
  Creates a pharmacy.

  ## Examples

      iex> create_pharmacy(%{field: value})
      {:ok, %Pharmacy{}}

      iex> create_pharmacy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pharmacy(attrs \\ %{}) do
    %Pharmacy{}
    |> Pharmacy.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pharmacy.

  ## Examples

      iex> update_pharmacy(pharmacy, %{field: new_value})
      {:ok, %Pharmacy{}}

      iex> update_pharmacy(pharmacy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pharmacy(%Pharmacy{} = pharmacy, attrs) do
    pharmacy
    |> Pharmacy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Pharmacy.

  ## Examples

      iex> delete_pharmacy(pharmacy)
      {:ok, %Pharmacy{}}

      iex> delete_pharmacy(pharmacy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pharmacy(%Pharmacy{} = pharmacy) do
    Repo.delete(pharmacy)
  end

  @doc """
  Verifies whether the credentials are legitimate.

  Returns either `{:ok, pharmacy}` or `{:error, reason}`.

  Seriously, Comeonin is a beautiful, beautiful library.

  ## Examples

      iex> authenticate_pharmacy("Foo Pharmacy", "password")
      {:ok, %Pharmacy{}}

      iex> authenticate_pharmacy("Foo Pharmacy", "bad password")
      {:error, "invalid password"}

      iex> authenticate_pharmacy("Nonsense", "a password")
      {:error, "invalid user-identifier"}

  """
  def authenticate_pharmacy(name, password) do
    pharmacy = get_pharmacy_by(%{name: name})
    Comeonin.Pbkdf2.check_pass(pharmacy, password)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pharmacy changes.

  ## Examples

      iex> change_pharmacy(pharmacy)
      %Ecto.Changeset{source: %Pharmacy{}}

  """
  def change_pharmacy(%Pharmacy{} = pharmacy) do
    Pharmacy.changeset(pharmacy, %{})
  end

  alias Test.Pharmacies.Location

  @doc """
  Get a list of locations for the given pharmacy

  ## Examples

      iex> list_locations_for_pharmacy(%Pharmacy{id: 1, ...})
      [%Location{}, ...]

  """
  def list_locations_for_pharmacy(%Pharmacy{id: pharmacy_id}) do
    Location
    |> where(pharmacy_id: ^pharmacy_id)
    |> Repo.all()
  end

  @doc """
  Get a single location for the given pharmacy

  ## Examples

      iex> get_location_for_pharmacy!(1, %Pharmacy{id: 1, ...})
      %Location{}

  """
  def get_location_for_pharmacy!(id, %Pharmacy{id: pharmacy_id}) do
    Location
    |> where(pharmacy_id: ^pharmacy_id)
    |> Repo.get!(id)
  end

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{source: %Location{}}

  """
  def change_location(%Location{} = location) do
    Location.changeset(location, %{})
  end
end
