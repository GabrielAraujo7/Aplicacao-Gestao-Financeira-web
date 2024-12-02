defmodule ProjectDelta.Repo.Migrations.CreateReceitas do
  use Ecto.Migration

  def change do
    create table(:receitas) do
      add :descricao, :string
      add :valor, :decimal
      add :data, :date
      add :categoria, :string

      timestamps(type: :utc_datetime)
    end
  end
end
