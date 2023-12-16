defmodule EcclesiaDb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EcclesiaDbWeb.Telemetry,
      EcclesiaDb.Repo,
      {DNSCluster, query: Application.get_env(:ecclesia_db, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: EcclesiaDb.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: EcclesiaDb.Finch},
      # Start a worker by calling: EcclesiaDb.Worker.start_link(arg)
      # {EcclesiaDb.Worker, arg},
      # Start to serve requests, typically the last entry
      EcclesiaDbWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EcclesiaDb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EcclesiaDbWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
