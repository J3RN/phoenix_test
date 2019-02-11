defmodule Test.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :patient_id, references(:patients, on_delete: :delete_all), null: false
      add :prescription_id, references(:prescriptions, on_delete: :delete_all), null: false
      add :location_id, references(:locations, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:orders, [:patient_id])
    create index(:orders, [:prescription_id])
    create index(:orders, [:location_id])
  end
end
