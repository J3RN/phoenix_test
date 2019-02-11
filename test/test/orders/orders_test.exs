defmodule Test.OrdersTest do
  use Test.DataCase

  alias Test.Orders

  describe "prescriptions" do
    alias Test.Orders.Prescription

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    test "list_prescriptions/0 returns all prescriptions" do
      prescription = insert(:prescription)
      assert Orders.list_prescriptions() == [prescription]
    end

    test "get_prescription!/1 returns the prescription with given id" do
      prescription = insert(:prescription)
      assert Orders.get_prescription!(prescription.id) == prescription
    end

    test "create_prescription/1 with valid data creates a prescription" do
      assert {:ok, %Prescription{} = prescription} = Orders.create_prescription(@valid_attrs)
      assert prescription.name == "some name"
    end

    test "create_prescription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_prescription(@invalid_attrs)
    end

    test "update_prescription/2 with valid data updates the prescription" do
      prescription = insert(:prescription)
      assert {:ok, %Prescription{} = prescription} = Orders.update_prescription(prescription, @update_attrs)
      assert prescription.name == "some updated name"
    end

    test "update_prescription/2 with invalid data returns error changeset" do
      prescription = insert(:prescription)
      assert {:error, %Ecto.Changeset{}} = Orders.update_prescription(prescription, @invalid_attrs)
      assert prescription == Orders.get_prescription!(prescription.id)
    end

    test "delete_prescription/1 deletes the prescription" do
      prescription = insert(:prescription)
      assert {:ok, %Prescription{}} = Orders.delete_prescription(prescription)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_prescription!(prescription.id) end
    end

    test "change_prescription/1 returns a prescription changeset" do
      prescription = insert(:prescription)
      assert %Ecto.Changeset{} = Orders.change_prescription(prescription)
    end
  end
end
