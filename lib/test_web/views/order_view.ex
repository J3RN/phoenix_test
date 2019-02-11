defmodule TestWeb.OrderView do
  use TestWeb, :view

  alias Test.{Orders, Pharmacies}

  def patient_name(%Orders.Patient{} = patient) do
    "#{patient.first_name} #{patient.last_name}"
  end

  def coordinates(%Pharmacies.Location{} = location) do
    "#{location.latitude}, #{location.longitude}"
  end
end
