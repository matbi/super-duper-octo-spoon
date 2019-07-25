defmodule NetguruWeb.Guardian.Serializer do
    @behaviour Guardian.Serializer
  
    alias Netguru.Repo
    alias Netguru.Schema.Author
  
    def for_token(user = %Author{}), do: { :ok, "User:#{user.id}" }
    def for_token(_), do: { :error, "Unknown resource type" }
  
    def from_token("User:" <> id), do: { :ok, Repo.get(Author, id) }
    def from_token(_), do: { :error, "Unknown resource type" }
  end