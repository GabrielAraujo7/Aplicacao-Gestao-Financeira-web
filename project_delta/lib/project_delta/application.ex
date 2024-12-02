defmodule ProjectDelta.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ProjectDeltaWeb.Telemetry,
      ProjectDelta.Repo,
      {DNSCluster, query: Application.get_env(:project_delta, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ProjectDelta.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ProjectDelta.Finch},
      # Start a worker by calling: ProjectDelta.Worker.start_link(arg)
      # {ProjectDelta.Worker, arg},
      # Start to serve requests, typically the last entry
      ProjectDeltaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProjectDelta.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ProjectDeltaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
