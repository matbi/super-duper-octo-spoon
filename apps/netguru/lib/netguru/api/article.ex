defmodule Netguru.API.Article do
    alias Netguru.Schema.Article
    alias Netguru.Repo

    def get_article!(id), do: Repo.get! Article, id

    @spec delete_article(id :: String.t) :: {:ok, %Article{}} | {:error, :not_found}
    def delete_article(id) do
        case Repo.get(Article, id) do
            %Article{} = article -> Repo.delete(article)
            _ -> {:error, :not_found}
        end
    end

    @spec create_article(article :: map) :: {:ok, %Article{}} | {:error, %Ecto.Changeset{}}
    def create_article(%{} = article) do
        article = Map.put(article, "published_date", DateTime.utc_now)
        changeset = Article.changeset(%Article{}, article)

        Repo.insert changeset
    end

    @doc """
        Returns all the articles from the db.

        Possible options:
            - preload (default false)
    """
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