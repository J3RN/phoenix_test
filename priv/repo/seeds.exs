# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Test.Repo.insert!(%Test.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Test.Repo
alias Test.Pharmacies.{Pharmacy, Location}
alias Test.Orders.{Prescription, Patient, Order}

pharmacy1 = Repo.insert!(%Pharmacy{name: "Alfa Pharmacy"})
pharmacy2 = Repo.insert!(%Pharmacy{name: "Bravo Pharmacy"})

location1 = Repo.insert!(%Location{latitude: "39.9612", longitude: "82.9988", pharmacy_id: pharmacy1.id})
location2 = Repo.insert!(%Location{latitude: "40.9612", longitude: "72.9988", pharmacy_id: pharmacy2.id})

prescription1 = Repo.insert!(%Prescription{name: "Allegra"})
prescription2 = Repo.insert!(%Prescription{name: "Rolaids"})

patient1 = Repo.insert!(%Patient{first_name: "First", last_name: "User"})
patient2 = Repo.insert!(%Patient{first_name: "Second", last_name: "User"})

Repo.insert!(%Order{
  patient_id: patient1.id,
  prescription_id: prescription1.id,
  location_id: location1.id
})

Repo.insert!(%Order{
  patient_id: patient2.id,
  prescription_id: prescription2.id,
  location_id: location2.id
})
