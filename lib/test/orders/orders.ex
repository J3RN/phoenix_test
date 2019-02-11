defmodule Test.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias Test.Repo

  alias Test.Orders.Prescription

  @doc """
  Returns the list of prescriptions.

  ## Examples

      iex> list_prescriptions()
      [%Prescription{}, ...]

  """
  def list_prescriptions do
    Repo.all(Prescription)
  end

  @doc """
  Gets a single prescription.

  Raises `Ecto.NoResultsError` if the Prescription does not exist.

  ## Examples

      iex> get_prescription!(123)
      %Prescription{}

      iex> get_prescription!(456)
      ** (Ecto.NoResultsError)

  """
  def get_prescription!(id), do: Repo.get!(Prescription, id)

  @doc """
  Creates a prescription.

  ## Examples

      iex> create_prescription(%{field: value})
      {:ok, %Prescription{}}

      iex> create_prescription(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_prescription(attrs \\ %{}) do
    %Prescription{}
    |> Prescription.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a prescription.

  ## Examples

      iex> update_prescription(prescription, %{field: new_value})
      {:ok, %Prescription{}}

      iex> update_prescription(prescription, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_prescription(%Prescription{} = prescription, attrs) do
    prescription
    |> Prescription.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Prescription.

  ## Examples

      iex> delete_prescription(prescription)
      {:ok, %Prescription{}}

      iex> delete_prescription(prescription)
      {:error, %Ecto.Changeset{}}

  """
  def delete_prescription(%Prescription{} = prescription) do
    Repo.delete(prescription)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking prescription changes.

  ## Examples

      iex> change_prescription(prescription)
      %Ecto.Changeset{source: %Prescription{}}

  """
  def change_prescription(%Prescription{} = prescription) do
    Prescription.changeset(prescription, %{})
  end

  alias Test.Orders.Patient

  @doc """
  Returns the list of patients.

  ## Examples

      iex> list_patients()
      [%Patient{}, ...]

  """
  def list_patients do
    Repo.all(Patient)
  end

  @doc """
  Gets a single patient.

  Raises `Ecto.NoResultsError` if the Patient does not exist.

  ## Examples

      iex> get_patient!(123)
      %Patient{}

      iex> get_patient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_patient!(id), do: Repo.get!(Patient, id)

  @doc """
  Creates a patient.

  ## Examples

      iex> create_patient(%{field: value})
      {:ok, %Patient{}}

      iex> create_patient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_patient(attrs \\ %{}) do
    %Patient{}
    |> Patient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a patient.

  ## Examples

      iex> update_patient(patient, %{field: new_value})
      {:ok, %Patient{}}

      iex> update_patient(patient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_patient(%Patient{} = patient, attrs) do
    patient
    |> Patient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Patient.

  ## Examples

      iex> delete_patient(patient)
      {:ok, %Patient{}}

      iex> delete_patient(patient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_patient(%Patient{} = patient) do
    Repo.delete(patient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking patient changes.

  ## Examples

      iex> change_patient(patient)
      %Ecto.Changeset{source: %Patient{}}

  """
  def change_patient(%Patient{} = patient) do
    Patient.changeset(patient, %{})
  end
end
