defmodule NetguruWeb.Guardian.Pipeline do
    use Guardian.Plug.Pipeline, otp_app: :netguru_web, module: NetguruWeb.Guardian.Serializer, error_handler: NetguruWeb.Guardian.ErrorHandler

    @claims %{iss: "NetguruWeb"}

    plug Guardian.Plug.VerifySession, claims: @claims
    plug Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource, allow_blank: true
end