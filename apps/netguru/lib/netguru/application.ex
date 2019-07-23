defmodule Netguru.Application do
  @moduledoc """
  The Netguru Application Service.

  The netguru system business domain lives in this application.

  Exposes API to clients such as the `NetguruWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Netguru.Repo, []),
    ], strategy: :one_for_one, name: Netguru.Supervisor)
  end
end
