defmodule Netguru.API.Author do
    @moduledoc false
    alias Netguru.Schema.Author
    alias Netguru.Repo

    def get_author!(id), do: Repo.get!(Author, id)

    @spec create_author(author :: map) :: {:ok, %Author{}} | {:error, %Ecto.Changeset{}}
    def create_author(%{} = author) do
        %Author{}
            |> Author.changeset(author)
            |> Repo.insert
    end

    @spec update_author(id :: String.t, update_author :: map) :: {:ok, %Author{}} | {:error, %Ecto.Changeset{}} | {:error, :not_found}
    def update_author(id, %{} = updated_author) do
        case Repo.get(Author, id) do
            %Author{} = author -> author
                                    |> Author.changeset(updated_author)
                                    |> Repo.update()
            _ -> {:error, :not_found}
        end
    end
end
