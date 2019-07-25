defmodule Netguru.API.Article do
    alias Netguru.Schema.Article
    alias Netguru.Repo

    def get_article!(id), do: Repo.get! Article, id
    def delete_article(article), do: Repo.delete article
end