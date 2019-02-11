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

  describe "patients" do
    alias Test.Orders.Patient

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name"}
    @invalid_attrs %{first_name: nil, last_name: nil}

    test "list_patients/0 returns all patients" do
      patient = insert(:patient)
      assert Orders.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = insert(:patient)
      assert Orders.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      assert {:ok, %Patient{} = patient} = Orders.create_patient(@valid_attrs)
      assert patient.first_name == "some first_name"
      assert patient.last_name == "some last_name"
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = insert(:patient)
      assert {:ok, %Patient{} = patient} = Orders.update_patient(patient, @update_attrs)
      assert patient.first_name == "some updated first_name"
      assert patient.last_name == "some updated last_name"
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = insert(:patient)
      assert {:error, %Ecto.Changeset{}} = Orders.update_patient(patient, @invalid_attrs)
      assert patient == Orders.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = insert(:patient)
      assert {:ok, %Patient{}} = Orders.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = insert(:patient)
      assert %Ecto.Changeset{} = Orders.change_patient(patient)
    end
  end

  describe "orders" do
    alias Test.Orders.Order

    @invalid_attrs %{patient_id: nil}

    test "list_orders/0 returns all orders" do
      order = insert(:order)
      assert [%Order{} = retrieved_order] = Orders.list_orders()
      assert matching_order?(retrieved_order, order)
    end

    test "get_order!/1 returns the order with given id" do
      order = insert(:order)
      assert %Order{} = retrieved_order = Orders.get_order!(order.id)
      assert matching_order?(retrieved_order, order)
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = params_with_assocs(:order)
      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = insert(:order)
      update_attrs = params_with_assocs(:order)
      assert {:ok, %Order{} = retrieved_order} = Orders.update_order(order, update_attrs)
      assert matching_order?(retrieved_order, update_attrs)
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = insert(:order)
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert matching_order?(order, Orders.get_order!(order.id))
    end

    test "delete_order/1 deletes the order" do
      order = insert(:order)
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = insert(:order)
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end

    defp matching_order?(one, two) do
      Enum.all?([:patient_id, :prescription_id, :location_id], fn(attr) ->
        Map.get(one, attr) == Map.get(two, attr)
      end)
    end
  end
end
