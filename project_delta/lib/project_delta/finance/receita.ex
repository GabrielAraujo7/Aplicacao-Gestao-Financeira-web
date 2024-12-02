defmodule ProjectDelta.Finance.Receita do
  use Ecto.Schema
  import Ecto.Changeset

  schema "receitas" do
    field :data, :date
    field :descricao, :string
    field :valor, :decimal
    field :categoria, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(receita, attrs) do
    receita
    |> cast(attrs, [:descricao, :valor, :data, :categoria])
    |> validate_required([:descricao, :valor, :data, :categoria])
  end
end
