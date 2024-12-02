defmodule ProjectDeltaWeb.DespesaControllerTest do
  use ProjectDeltaWeb.ConnCase

  import ProjectDelta.FinanceFixtures

  @create_attrs %{data: ~D[2024-11-18], descricao: "some descricao", valor: "120.5", categoria: "some categoria"}
  @update_attrs %{data: ~D[2024-11-19], descricao: "some updated descricao", valor: "456.7", categoria: "some updated categoria"}
  @invalid_attrs %{data: nil, descricao: nil, valor: nil, categoria: nil}

  describe "index" do
    test "lists all despesas", %{conn: conn} do
      conn = get(conn, ~p"/despesas")
      assert html_response(conn, 200) =~ "Listing Despesas"
    end
  end

  describe "new despesa" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/despesas/new")
      assert html_response(conn, 200) =~ "New Despesa"
    end
  end

  describe "create despesa" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/despesas", despesa: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/despesas/#{id}"

      conn = get(conn, ~p"/despesas/#{id}")
      assert html_response(conn, 200) =~ "Despesa #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/despesas", despesa: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Despesa"
    end
  end

  describe "edit despesa" do
    setup [:create_despesa]

    test "renders form for editing chosen despesa", %{conn: conn, despesa: despesa} do
      conn = get(conn, ~p"/despesas/#{despesa}/edit")
      assert html_response(conn, 200) =~ "Edit Despesa"
    end
  end

  describe "update despesa" do
    setup [:create_despesa]

    test "redirects when data is valid", %{conn: conn, despesa: despesa} do
      conn = put(conn, ~p"/despesas/#{despesa}", despesa: @update_attrs)
      assert redirected_to(conn) == ~p"/despesas/#{despesa}"

      conn = get(conn, ~p"/despesas/#{despesa}")
      assert html_response(conn, 200) =~ "some updated descricao"
    end

    test "renders errors when data is invalid", %{conn: conn, despesa: despesa} do
      conn = put(conn, ~p"/despesas/#{despesa}", despesa: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Despesa"
    end
  end

  describe "delete despesa" do
    setup [:create_despesa]

    test "deletes chosen despesa", %{conn: conn, despesa: despesa} do
      conn = delete(conn, ~p"/despesas/#{despesa}")
      assert redirected_to(conn) == ~p"/despesas"

      assert_error_sent 404, fn ->
        get(conn, ~p"/despesas/#{despesa}")
      end
    end
  end

  defp create_despesa(_) do
    despesa = despesa_fixture()
    %{despesa: despesa}
  end
end
