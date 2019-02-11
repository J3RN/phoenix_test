defmodule Test.Repo.Migrations.AddPasswordHashToPharmacies do
  use Ecto.Migration

  def change do
    alter table(:pharmacies) do
      add :password_hash, :string, null: false
    end
  end
end
