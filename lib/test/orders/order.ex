defmodule Test.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset


  schema "orders" do
    belongs_to :patient, Test.Orders.Patient
    belongs_to :prescription, Test.Orders.Prescription
    belongs_to :location, Test.Pharmacies.Location

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:patient_id, :prescription_id, :location_id])
    |> validate_required([:patient_id, :prescription_id, :location_id])
  end
end
