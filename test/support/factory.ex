defmodule Test.Factory do
  use ExMachina.Ecto, repo: Test.Repo

  def pharmacy_factory do
    %Test.Pharmacies.Pharmacy{
      name: "CVS Pharmacy"
    }
  end

  def location_factory do
    %Test.Pharmacies.Location{
      latitude: "39.9751",
      longitude: "-83.0467",
      pharmacy: build(:pharmacy)
    }
  end
end
