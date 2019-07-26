defmodule Netguru.API.Article do
    alias Netguru.Schema.Article
    alias Netguru.Repo

    def get_article!(id), do: Repo.get! Article, id
    def delete_article(%Article{} = article), do: Repo.delete article

    def create_article(%{} = article) do
        article = Map.put(article, "published_date", DateTime.utc_now)
        changeset = Article.changeset(%Article{}, article)

        Repo.insert changeset
    end
end