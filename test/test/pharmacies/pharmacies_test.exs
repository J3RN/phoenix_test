defmodule Test.PharmaciesTest do
  use Test.DataCase

  alias Test.Pharmacies

  describe "pharmacies" do
    alias Test.Pharmacies.Pharmacy

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def pharmacy_fixture(attrs \\ %{}) do
      {:ok, pharmacy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pharmacies.create_pharmacy()

      pharmacy
    end

    test "get_pharmacy!/1 returns the pharmacy with given id" do
      pharmacy = pharmacy_fixture()
      assert Pharmacies.get_pharmacy!(pharmacy.id) == pharmacy
    end

    test "create_pharmacy/1 with valid data creates a pharmacy" do
      assert {:ok, %Pharmacy{} = pharmacy} = Pharmacies.create_pharmacy(@valid_attrs)
      assert pharmacy.name == "some name"
    end

    test "create_pharmacy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pharmacies.create_pharmacy(@invalid_attrs)
    end

    test "update_pharmacy/2 with valid data updates the pharmacy" do
      pharmacy = pharmacy_fixture()
      assert {:ok, %Pharmacy{} = pharmacy} = Pharmacies.update_pharmacy(pharmacy, @update_attrs)
      assert pharmacy.name == "some updated name"
    end

    test "update_pharmacy/2 with invalid data returns error changeset" do
      pharmacy = pharmacy_fixture()
      assert {:error, %Ecto.Changeset{}} = Pharmacies.update_pharmacy(pharmacy, @invalid_attrs)
      assert pharmacy == Pharmacies.get_pharmacy!(pharmacy.id)
    end

    test "delete_pharmacy/1 deletes the pharmacy" do
      pharmacy = pharmacy_fixture()
      assert {:ok, %Pharmacy{}} = Pharmacies.delete_pharmacy(pharmacy)
      assert_raise Ecto.NoResultsError, fn -> Pharmacies.get_pharmacy!(pharmacy.id) end
    end

    test "change_pharmacy/1 returns a pharmacy changeset" do
      pharmacy = pharmacy_fixture()
      assert %Ecto.Changeset{} = Pharmacies.change_pharmacy(pharmacy)
    end
  end

  describe "locations" do
    alias Test.Pharmacies.Location

    @valid_attrs %{latitude: "some latitude", longitude: "some longitude", pharmacy_id: pharmacy_fixture().id}
    @update_attrs %{latitude: "some updated latitude", longitude: "some updated longitude"}
    @invalid_attrs %{latitude: nil, longitude: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pharmacies.create_location()

      location
    end

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Pharmacies.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Pharmacies.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = Pharmacies.create_location(@valid_attrs)
      assert location.latitude == "some latitude"
      assert location.longitude == "some longitude"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pharmacies.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, %Location{} = location} = Pharmacies.update_location(location, @update_attrs)
      assert location.latitude == "some updated latitude"
      assert location.longitude == "some updated longitude"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Pharmacies.update_location(location, @invalid_attrs)
      assert location == Pharmacies.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Pharmacies.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Pharmacies.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Pharmacies.change_location(location)
    end
  end
end
