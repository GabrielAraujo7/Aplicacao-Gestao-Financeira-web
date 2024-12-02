defmodule ProjectDeltaWeb.ReceitaControllerTest do
  use ProjectDeltaWeb.ConnCase

  import ProjectDelta.FinanceFixtures

  @create_attrs %{data: ~D[2024-11-18], descricao: "some descricao", valor: "120.5", categoria: "some categoria"}
  @update_attrs %{data: ~D[2024-11-19], descricao: "some updated descricao", valor: "456.7", categoria: "some updated categoria"}
  @invalid_attrs %{data: nil, descricao: nil, valor: nil, categoria: nil}

  describe "index" do
    test "lists all receitas", %{conn: conn} do
      conn = get(conn, ~p"/receitas")
      assert html_response(conn, 200) =~ "Listing Receitas"
    end
  end

  describe "new receita" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/receitas/new")
      assert html_response(conn, 200) =~ "New Receita"
    end
  end

  describe "create receita" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/receitas", receita: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/receitas/#{id}"

      conn = get(conn, ~p"/receitas/#{id}")
      assert html_response(conn, 200) =~ "Receita #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/receitas", receita: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Receita"
    end
  end

  describe "edit receita" do
    setup [:create_receita]

    test "renders form for editing chosen receita", %{conn: conn, receita: receita} do
      conn = get(conn, ~p"/receitas/#{receita}/edit")
      assert html_response(conn, 200) =~ "Edit Receita"
    end
  end

  describe "update receita" do
    setup [:create_receita]

    test "redirects when data is valid", %{conn: conn, receita: receita} do
      conn = put(conn, ~p"/receitas/#{receita}", receita: @update_attrs)
      assert redirected_to(conn) == ~p"/receitas/#{receita}"

      conn = get(conn, ~p"/receitas/#{receita}")
      assert html_response(conn, 200) =~ "some updated descricao"
    end

    test "renders errors when data is invalid", %{conn: conn, receita: receita} do
      conn = put(conn, ~p"/receitas/#{receita}", receita: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Receita"
    end
  end

  describe "delete receita" do
    setup [:create_receita]

    test "deletes chosen receita", %{conn: conn, receita: receita} do
      conn = delete(conn, ~p"/receitas/#{receita}")
      assert redirected_to(conn) == ~p"/receitas"

      assert_error_sent 404, fn ->
        get(conn, ~p"/receitas/#{receita}")
      end
    end
  end

  defp create_receita(_) do
    receita = receita_fixture()
    %{receita: receita}
  end
end
