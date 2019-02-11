defmodule Test.Factory do
  use ExMachina.Ecto, repo: Test.Repo

  def pharmacy_factory do
    %Test.Pharmacies.Pharmacy{
      name: sequence("Pharmacy"),
      password: sequence("password"),
      password_hash: sequence("$pbkdf2-sha512$160000$password")
    }
  end

  def location_factory do
    %Test.Pharmacies.Location{
      latitude: sequence("39.975"),
      longitude: sequence("-83.046"),
      pharmacy: build(:pharmacy)
    }
  end

  def prescription_factory do
    %Test.Orders.Prescription{
      name: sequence("Drug")
    }
  end

  def patient_factory do
    %Test.Orders.Patient{
      first_name: sequence("First"),
      last_name: sequence("Last")
    }
  end

  def order_factory do
    %Test.Orders.Order{
      patient: build(:patient),
      prescription: build(:prescription),
      location: build(:location)
    }
  end
end
