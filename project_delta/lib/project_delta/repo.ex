defmodule ProjectDelta.Repo do
  use Ecto.Repo,
    otp_app: :project_delta,
    adapter: Ecto.Adapters.Postgres
end
