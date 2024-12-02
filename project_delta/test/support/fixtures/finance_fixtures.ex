defmodule ProjectDelta.FinanceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ProjectDelta.Finance` context.
  """

  @doc """
  Generate a receita.
  """
  def receita_fixture(attrs \\ %{}) do
    {:ok, receita} =
      attrs
      |> Enum.into(%{
        categoria: "some categoria",
        data: ~D[2024-11-18],
        descricao: "some descricao",
        valor: "120.5"
      })
      |> ProjectDelta.Finance.create_receita()

    receita
  end

  @doc """
  Generate a despesa.
  """
  def despesa_fixture(attrs \\ %{}) do
    {:ok, despesa} =
      attrs
      |> Enum.into(%{
        categoria: "some categoria",
        data: ~D[2024-11-18],
        descricao: "some descricao",
        valor: "120.5"
      })
      |> ProjectDelta.Finance.create_despesa()

    despesa
  end
end
