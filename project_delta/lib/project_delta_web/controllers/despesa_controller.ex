defmodule ProjectDeltaWeb.DespesaController do
  use ProjectDeltaWeb, :controller

  alias ProjectDelta.Finance
  alias ProjectDelta.Finance.Despesa


  def index(conn, params) do
    if conn.assigns[:current_user] do
      despesas = Finance.list_despesas_with_filters(params)
      render(conn, :index, despesas: despesas)
    else
      conn
      |> put_flash(:error, "É necessário estar logado para acessar essa página.")
      |> redirect(to: "/login")
    end
  end


  def new(conn, _params) do
    changeset = Finance.change_despesa(%Despesa{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"despesa" => despesa_params}) do
    case Finance.create_despesa(despesa_params) do
      {:ok, despesa} ->
        conn
        |> put_flash(:info, "Despesa criada com sucesso!")
        |> redirect(to: ~p"/despesas/#{despesa}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    despesa = Finance.get_despesa!(id)
    render(conn, :show, despesa: despesa)
  end

  def edit(conn, %{"id" => id}) do
    despesa = Finance.get_despesa!(id)
    changeset = Finance.change_despesa(despesa)
    render(conn, :edit, despesa: despesa, changeset: changeset)
  end

  def update(conn, %{"id" => id, "despesa" => despesa_params}) do
    despesa = Finance.get_despesa!(id)

    case Finance.update_despesa(despesa, despesa_params) do
      {:ok, despesa} ->
        conn
        |> put_flash(:info, "Despesa atualizada com sucesso!")
        |> redirect(to: ~p"/despesas/#{despesa}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, despesa: despesa, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    despesa = Finance.get_despesa!(id)
    {:ok, _despesa} = Finance.delete_despesa(despesa)

    conn
    |> put_flash(:info, "Despesa deletada com sucesso!")
    |> redirect(to: ~p"/despesas")
  end
end
