defmodule ProjectDeltaWeb.ReceitaController do
  use ProjectDeltaWeb, :controller

  alias ProjectDelta.Finance
  alias ProjectDelta.Finance.Receita
  
  def index(conn, params) do
    if conn.assigns[:current_user] do
      # Passa os parâmetros para aplicar os filtros
      receitas = Finance.list_receitas_with_filters(params)
      render(conn, :index, receitas: receitas)
    else
      conn
      |> put_flash(:error, "Você precisa estar logado para acessar as receitas.")
      |> redirect(to: "/login")
    end
  end


  def new(conn, _params) do
    changeset = Finance.change_receita(%Receita{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"receita" => receita_params}) do
    case Finance.create_receita(receita_params) do
      {:ok, receita} ->
        conn
        |> put_flash(:info, "Receita criada com sucesso!")
        |> redirect(to: ~p"/receitas/#{receita}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    receita = Finance.get_receita!(id)
    render(conn, :show, receita: receita)
  end

  def edit(conn, %{"id" => id}) do
    receita = Finance.get_receita!(id)
    changeset = Finance.change_receita(receita)
    render(conn, :edit, receita: receita, changeset: changeset)
  end

  def update(conn, %{"id" => id, "receita" => receita_params}) do
    receita = Finance.get_receita!(id)

    case Finance.update_receita(receita, receita_params) do
      {:ok, receita} ->
        conn
        |> put_flash(:info, "Receita atualizada com sucesso!")
        |> redirect(to: ~p"/receitas/#{receita}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, receita: receita, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    receita = Finance.get_receita!(id)
    {:ok, _receita} = Finance.delete_receita(receita)

    conn
    |> put_flash(:info, "Receita deletada com sucesso!")
    |> redirect(to: ~p"/receitas")
  end
end
