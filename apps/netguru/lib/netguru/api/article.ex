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

    def index_articles(opts \\ []) do
        preload = Keyword.get(opts, :preload, false)

        articles = Repo.all(Article)
        if preload do
            Repo.preload(articles, [:author])
        else
            articles
        end
    end
end