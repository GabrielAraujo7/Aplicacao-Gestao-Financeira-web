

defmodule ProjectDeltaWeb.PageController do
  use ProjectDeltaWeb, :controller

  def home(conn, _params) do
    render(conn, ProjectDeltaWeb.PageHTML, "index.html")
  end
  
end
