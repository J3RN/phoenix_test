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
end
