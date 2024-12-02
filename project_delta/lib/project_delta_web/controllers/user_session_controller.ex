defmodule ProjectDeltaWeb.UserSessionController do
  use ProjectDeltaWeb, :controller

  alias ProjectDelta.Accounts
  alias ProjectDeltaWeb.UserAuth



  def create(conn, %{"_action" => "registered"} = params) do
    create(conn, params, "Conta criada com sucesso!")
  end

  def create(conn, %{"_action" => "password_updated"} = params) do
    conn
    |> put_session(:user_return_to, ~p"/users/settings")
    |> create(params, "Senha atualizada com sucesso!")
  end

  def create(conn, params) do
    create(conn, params, "Bem-vindo de volta!")
  end

  defp create(conn, %{"user" => user_params}, info) do
    %{"email" => email, "password" => password} = user_params

    # Tenta autenticar o usuário com email e senha
    if user = Accounts.get_user_by_email_and_password(email, password) do
      # Se autenticar com sucesso, redireciona para a página desejada (pode ser a página original ou /receitas)
      conn
      |> put_flash(:info, info)
      |> UserAuth.log_in_user(user, user_params)
      |> redirect(to: get_session(conn, :user_return_to) || "/receitas")
    else
      # Se falhar a autenticação, exibe a mensagem de erro e renderiza o formulário de login novamente
      conn
      |> put_flash(:error, "Email ou senha inválida!")
      |> put_flash(:email, String.slice(email, 0, 160))  # Preenche o campo de email com o valor informado
        |> redirect(to: ~p"/users/log_in")
    end
  end


  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Deslogado com sucesso!")
    |> UserAuth.log_out_user()
    |> redirect(to: ~p"/users/log_in")
  end
end
