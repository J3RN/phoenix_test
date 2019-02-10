defmodule Test.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :latitude, :string, null: false
      add :longitude, :string, null: false
      add :pharmacy_id, references(:pharmacies, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:locations, [:pharmacy_id])
    create unique_index(:locations, [:latitude, :longitude])
  end
end
