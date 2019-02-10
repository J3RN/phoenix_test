defmodule Test.Pharmacies.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    belongs_to(:pharmacy, Test.Pharmacies.Pharmacy)

    field(:latitude, :string)
    field(:longitude, :string)

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:latitude, :longitude, :pharmacy_id])
    |> validate_required([:latitude, :longitude])
    |> unique_constraint(:latitude, name: :locations_latitude_longitude_index)
    |> unique_constraint(:longitude, name: :locations_latitude_longitude_index)
  end
end
