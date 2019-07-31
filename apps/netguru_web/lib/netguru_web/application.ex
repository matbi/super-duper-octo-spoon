defmodule NetguruWeb.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(NetguruWeb.Endpoint, []),
      # Start your own worker by calling: NetguruWeb.Worker.start_link(arg1, arg2, arg3)
      # worker(NetguruWeb.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NetguruWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NetguruWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
