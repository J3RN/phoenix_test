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

pharmacy1 = Repo.insert!(%Pharmacy{name: "Alfa Pharmacy"})
pharmacy2 = Repo.insert!(%Pharmacy{name: "Bravo Pharmacy"})

location1 = Repo.insert!(%Location{latitude: "39.9612", longitude: "82.9988", pharmacy_id: pharmacy1.id})
location2 = Repo.insert!(%Location{latitude: "40.9612", longitude: "72.9988", pharmacy_id: pharmacy2.id})
