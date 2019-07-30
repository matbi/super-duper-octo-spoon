defmodule NetguruWeb.AuthorController do
    use NetguruWeb, :controller

    alias Netguru.Schema.Author
    alias Netguru.API.Author, as: API

    action_fallback NetguruWeb.FallbackController

    def show(conn, %{"id" => id}) do
        author = API.get_author! id
        render conn, "show.json", author: author
    end

    def create(conn, %{"author" => author}) do
        with {:ok, %Author{} = author} <- API.create_author(author) do
            {:ok, token, _} = NetguruWeb.Guardian.encode_and_sign(author)
            conn
                |> put_status(:created)
                |> json(%{"token" => token})
        end
    end

    def update(conn, %{"id" => id, "author" => updated_author}) do
        # raises for 404
        author = API.get_author! id
        with {:ok, %Author{} = author} <- API.update_author(id, updated_author) do
            render conn, "show.json", author: author
        end
    end
end