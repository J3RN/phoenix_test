defmodule Test.PharmaciesTest do
  use Test.DataCase

  alias Test.Pharmacies

  describe "pharmacies" do
    alias Test.Pharmacies.Pharmacy

    @update_attrs %{name: "Foobar"}
    @invalid_attrs %{name: nil}

    test "get_pharmacy!/1 returns the pharmacy with given id" do
      pharmacy = insert(:pharmacy)
      retrieved_pharmacy = Pharmacies.get_pharmacy!(pharmacy.id)
      assert %Pharmacy{} = retrieved_pharmacy
      assert retrieved_pharmacy.id == pharmacy.id
    end

    test "get_pharmacy_by/1 returns the pharmacy with the given attributes" do
      pharmacy = insert(:pharmacy)
      retrieved_pharmacy = Pharmacies.get_pharmacy_by(%{name: pharmacy.name})
      assert %Pharmacy{} = retrieved_pharmacy
      assert retrieved_pharmacy.id == pharmacy.id
    end

    test "get_pharmacy_by/1 returns nil if the pharmacy with the given attributes cannot be found" do
      assert Pharmacies.get_pharmacy_by(%{name: "A Pharmacy"}) == nil
    end

    test "create_pharmacy/1 with valid data creates a pharmacy" do
      password = "asdfasdf"

      valid_attrs =
        params_for(:pharmacy)
        |> Map.put(:password, password)
        |> Map.put(:password_confirmation, password)

      assert {:ok, %Pharmacy{} = pharmacy} = Pharmacies.create_pharmacy(valid_attrs)
      assert pharmacy.name == valid_attrs[:name]
    end

    test "create_pharmacy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pharmacies.create_pharmacy(@invalid_attrs)
    end

    test "update_pharmacy/2 with valid data updates the pharmacy" do
      pharmacy = insert(:pharmacy)
      assert {:ok, %Pharmacy{} = pharmacy} = Pharmacies.update_pharmacy(pharmacy, @update_attrs)
      assert pharmacy.name == @update_attrs[:name]
    end

    test "update_pharmacy/2 with invalid data returns error changeset" do
      pharmacy_attrs = params_for(:pharmacy)
      pharmacy = insert(:pharmacy, pharmacy_attrs)
      assert {:error, %Ecto.Changeset{}} = Pharmacies.update_pharmacy(pharmacy, @invalid_attrs)
      retrieved_pharmacy = Pharmacies.get_pharmacy!(pharmacy.id)
      assert retrieved_pharmacy.name == pharmacy_attrs[:name]
    end

    test "delete_pharmacy/1 deletes the pharmacy" do
      pharmacy = insert(:pharmacy)
      assert {:ok, %Pharmacy{}} = Pharmacies.delete_pharmacy(pharmacy)
      assert_raise Ecto.NoResultsError, fn -> Pharmacies.get_pharmacy!(pharmacy.id) end
    end

    test "authenticate_pharmacy/2 returns the pharmacy if creds are correct" do
      password = "foobar"
      pharmacy = insert(:pharmacy, %{password_hash: Comeonin.Pbkdf2.hashpwsalt(password)})

      assert {:ok, %Pharmacy{} = retrieved_pharmacy} =
               Pharmacies.authenticate_pharmacy(pharmacy.name, password)

      assert retrieved_pharmacy.id == pharmacy.id
    end

    test "authenticate_pharmacy/2 returns an error if the creds are incorrect" do
      password = "foobar"
      incorrect_password = "barbaz"
      pharmacy = insert(:pharmacy, %{password_hash: Comeonin.Pbkdf2.hashpwsalt(password)})

      assert {:error, _} = Pharmacies.authenticate_pharmacy(pharmacy.name, incorrect_password)
    end

    test "change_pharmacy/1 returns a pharmacy changeset" do
      pharmacy = insert(:pharmacy)
      assert %Ecto.Changeset{} = Pharmacies.change_pharmacy(pharmacy)
    end
  end

  describe "locations" do
    alias Test.Pharmacies.Location

    @update_attrs %{latitude: "12.345", longitude: "98.765"}
    @invalid_attrs %{latitude: nil, longitude: nil}

    test "list_locations_for_pharmacy/1 returns all locations for the pharmacy" do
      location = insert(:location)

      assert [%Location{} = retrieved_location] =
               Pharmacies.list_locations_for_pharmacy(location.pharmacy)

      assert retrieved_location.id == location.id
    end

    test "list_locations_for_pharmacy/1 does not return locations for other pharmacies" do
      pharmacy = insert(:pharmacy)
      location = insert(:location, %{pharmacy: pharmacy})

      other_pharmacy = insert(:pharmacy)
      _other_location = insert(:location, %{pharmacy: other_pharmacy})

      assert [%Location{} = retrieved_location] =
               Pharmacies.list_locations_for_pharmacy(location.pharmacy)

      assert retrieved_location.id == location.id
    end

    test "get_location_for_pharmacy!/2 returns the location with given id for the pharmacy" do
      location = insert(:location)
      retrieved_location = Pharmacies.get_location_for_pharmacy!(location.id, location.pharmacy)
      assert %Location{} = retrieved_location
      assert retrieved_location.id == location.id
    end

    test "get_location_for_pharmacy!/2 will not return a location for another pharmacy" do
      location = insert(:location)
      new_pharmacy = insert(:pharmacy)

      assert_raise Ecto.NoResultsError, fn ->
        Pharmacies.get_location_for_pharmacy!(location.id, new_pharmacy)
      end
    end

    test "create_location/1 with valid data creates a location" do
      valid_attrs = params_with_assocs(:location)
      assert {:ok, %Location{} = location} = Pharmacies.create_location(valid_attrs)
      assert location.latitude == valid_attrs[:latitude]
      assert location.longitude == valid_attrs[:longitude]
      assert location.pharmacy_id == valid_attrs[:pharmacy_id]
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pharmacies.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = insert(:location)
      assert {:ok, %Location{} = location} = Pharmacies.update_location(location, @update_attrs)
      assert location.latitude == @update_attrs[:latitude]
      assert location.longitude == @update_attrs[:longitude]
    end

    test "update_location/2 with invalid data returns error changeset" do
      location_attrs = params_for(:location)
      location = insert(:location, location_attrs)
      assert {:error, %Ecto.Changeset{}} = Pharmacies.update_location(location, @invalid_attrs)

      assert %Location{} =
               retrieved_location =
               Pharmacies.get_location_for_pharmacy!(location.id, location.pharmacy)

      assert retrieved_location.latitude == location_attrs[:latitude]
      assert retrieved_location.longitude == location_attrs[:longitude]
    end

    test "delete_location/1 deletes the location" do
      location = insert(:location)
      assert {:ok, %Location{}} = Pharmacies.delete_location(location)

      assert_raise Ecto.NoResultsError, fn ->
        Pharmacies.get_location_for_pharmacy!(location.id, location.pharmacy)
      end
    end

    test "change_location/1 returns a location changeset" do
      location = insert(:location)
      assert %Ecto.Changeset{} = Pharmacies.change_location(location)
    end
  end
end
