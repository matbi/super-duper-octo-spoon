defmodule Netguru.API.Author do
    alias Netguru.Schema.Author
    alias Netguru.Repo

    def get_author!(id), do: Repo.get!(Author, id)

    def create_author(%{} = author) do
        %Author{}
            |> Author.changeset(author)
            |> Repo.insert
    end

    def update_author(id, %{} = author) do
        Author
            |> Repo.get(id)
            |> Author.changeset(author)
            |> Repo.update
    end
end
