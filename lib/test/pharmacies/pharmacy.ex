defmodule Test.Pharmacies.Pharmacy do
  use Ecto.Schema
  import Ecto.Changeset


  schema "pharmacies" do
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def registration_changeset(pharmacy, attrs) do
    pharmacy
    |> cast(attrs, [:name, :password])
    |> validate_required([:name, :password])
    |> unique_constraint(:name)
    |> validate_length(:password, min: 8, max: 100)
    |> put_pass_hash()
  end

  @doc false
  def changeset(pharmacy, attrs) do
    pharmacy
    |> cast(attrs, [:name, :password])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> validate_length(:password, min: 8, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Pbkdf2.add_hash(password))
  end
  defp put_pass_hash(changeset), do: changeset
end
