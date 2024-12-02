defmodule ProjectDeltaWeb.LoginController do
  use ProjectDeltaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html") # Renderiza a página home
  end
end
