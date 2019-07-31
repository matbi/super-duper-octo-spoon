defmodule Netguru.API.Author do
    alias Netguru.Schema.Author
    alias Netguru.Repo

    def get_author!(id), do: Repo.get!(Author, id)

    def create_author(%{} = author) do
        %Author{}
            |> Author.changeset(author)
            |> Repo.insert
    end

    def update_author(id, %{} = updated_author) do
        case Repo.get(Author, id) do
            %Author{} = author -> author
                                    |> Author.changeset(updated_author)
                                    |> Repo.update()
            _ -> {:error, :not_found}
        end
    end
end
