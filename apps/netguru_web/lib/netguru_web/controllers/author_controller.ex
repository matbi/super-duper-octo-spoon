defmodule NetguruWeb.AuthorController do
    use NetguruWeb, :controller

    alias Netguru.Schema.Author
    alias Netguru.API.Author, as: API

    def show(conn, %{"id" => id}) do
        author = API.get_author! id
        render conn, "show.json", author: author
    end
end