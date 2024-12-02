defmodule ProjectDelta.FinanceTest do
  use ProjectDelta.DataCase

  alias ProjectDelta.Finance

  describe "receitas" do
    alias ProjectDelta.Finance.Receita

    import ProjectDelta.FinanceFixtures

    @invalid_attrs %{data: nil, descricao: nil, valor: nil, categoria: nil}

    test "list_receitas/0 returns all receitas" do
      receita = receita_fixture()
      assert Finance.list_receitas() == [receita]
    end

    test "get_receita!/1 returns the receita with given id" do
      receita = receita_fixture()
      assert Finance.get_receita!(receita.id) == receita
    end

    test "create_receita/1 with valid data creates a receita" do
      valid_attrs = %{data: ~D[2024-11-18], descricao: "some descricao", valor: "120.5", categoria: "some categoria"}

      assert {:ok, %Receita{} = receita} = Finance.create_receita(valid_attrs)
      assert receita.data == ~D[2024-11-18]
      assert receita.descricao == "some descricao"
      assert receita.valor == Decimal.new("120.5")
      assert receita.categoria == "some categoria"
    end

    test "create_receita/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_receita(@invalid_attrs)
    end

    test "update_receita/2 with valid data updates the receita" do
      receita = receita_fixture()
      update_attrs = %{data: ~D[2024-11-19], descricao: "some updated descricao", valor: "456.7", categoria: "some updated categoria"}

      assert {:ok, %Receita{} = receita} = Finance.update_receita(receita, update_attrs)
      assert receita.data == ~D[2024-11-19]
      assert receita.descricao == "some updated descricao"
      assert receita.valor == Decimal.new("456.7")
      assert receita.categoria == "some updated categoria"
    end

    test "update_receita/2 with invalid data returns error changeset" do
      receita = receita_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_receita(receita, @invalid_attrs)
      assert receita == Finance.get_receita!(receita.id)
    end

    test "delete_receita/1 deletes the receita" do
      receita = receita_fixture()
      assert {:ok, %Receita{}} = Finance.delete_receita(receita)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_receita!(receita.id) end
    end

    test "change_receita/1 returns a receita changeset" do
      receita = receita_fixture()
      assert %Ecto.Changeset{} = Finance.change_receita(receita)
    end
  end

  describe "despesas" do
    alias ProjectDelta.Finance.Despesa

    import ProjectDelta.FinanceFixtures

    @invalid_attrs %{data: nil, descricao: nil, valor: nil, categoria: nil}

    test "list_despesas/0 returns all despesas" do
      despesa = despesa_fixture()
      assert Finance.list_despesas() == [despesa]
    end

    test "get_despesa!/1 returns the despesa with given id" do
      despesa = despesa_fixture()
      assert Finance.get_despesa!(despesa.id) == despesa
    end

    test "create_despesa/1 with valid data creates a despesa" do
      valid_attrs = %{data: ~D[2024-11-18], descricao: "some descricao", valor: "120.5", categoria: "some categoria"}

      assert {:ok, %Despesa{} = despesa} = Finance.create_despesa(valid_attrs)
      assert despesa.data == ~D[2024-11-18]
      assert despesa.descricao == "some descricao"
      assert despesa.valor == Decimal.new("120.5")
      assert despesa.categoria == "some categoria"
    end

    test "create_despesa/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_despesa(@invalid_attrs)
    end

    test "update_despesa/2 with valid data updates the despesa" do
      despesa = despesa_fixture()
      update_attrs = %{data: ~D[2024-11-19], descricao: "some updated descricao", valor: "456.7", categoria: "some updated categoria"}

      assert {:ok, %Despesa{} = despesa} = Finance.update_despesa(despesa, update_attrs)
      assert despesa.data == ~D[2024-11-19]
      assert despesa.descricao == "some updated descricao"
      assert despesa.valor == Decimal.new("456.7")
      assert despesa.categoria == "some updated categoria"
    end

    test "update_despesa/2 with invalid data returns error changeset" do
      despesa = despesa_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_despesa(despesa, @invalid_attrs)
      assert despesa == Finance.get_despesa!(despesa.id)
    end

    test "delete_despesa/1 deletes the despesa" do
      despesa = despesa_fixture()
      assert {:ok, %Despesa{}} = Finance.delete_despesa(despesa)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_despesa!(despesa.id) end
    end

    test "change_despesa/1 returns a despesa changeset" do
      despesa = despesa_fixture()
      assert %Ecto.Changeset{} = Finance.change_despesa(despesa)
    end
  end
end
