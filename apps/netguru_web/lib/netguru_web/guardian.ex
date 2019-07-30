defmodule NetguruWeb.Guardian do
    use Guardian, otp_app: :netguru_web
    
    def subject_for_token(user, _claims) do
      {:ok, to_string(user.id)}
    end
  
    def resource_from_claims(%{"sub" => id}) do
      {:ok, Netguru.API.Author.get_author!(id)}
    end
  end