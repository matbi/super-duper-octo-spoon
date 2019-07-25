defmodule Netguru.API.Author do
    alias Netguru.Schema.Author
    alias Netguru.Repo

    def get_author!(id), do: Repo.get!(Author, id)
end
