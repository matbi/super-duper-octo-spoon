defmodule NetguruWeb.Guardian.ErrorHandler do
    import Plug.Conn

    @moduledoc """
      Handles the guardian errors
    """

    @behaviour Guardian.Plug.ErrorHandler

    @impl Guardian.Plug.ErrorHandler
    def auth_error(conn, {type, reason}, _opts) do
      body = JSON.encode!(%{message: to_string(type)})
      send_resp(conn, 401, body)
    end
end