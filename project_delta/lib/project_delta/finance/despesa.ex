defmodule ProjectDelta.Finance.Despesa do
  use Ecto.Schema
  import Ecto.Changeset

  schema "despesas" do
    field :data, :date
    field :descricao, :string
    field :valor, :decimal
    field :categoria, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(despesa, attrs) do
    despesa
    |> cast(attrs, [:descricao, :valor, :data, :categoria])
    |> validate_required([:descricao, :valor, :data, :categoria])
  end
end
