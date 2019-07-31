defmodule NetguruWeb.ArticleController do
    use NetguruWeb, :controller

    alias Netguru.Schema.Article
    alias Netguru.API.Article, as: API

    action_fallback NetguruWeb.FallbackController

    def index(conn, _) do
        articles = API.index_articles(preload: true)

        render conn, "index.json", articles: articles
    end

    def delete(conn, %{"id" => id}) do
        user = Guardian.Plug.current_resource(conn)
        article = API.get_article! id

        with :ok <- Bodyguard.permit(NetguruWeb.Policies.Article, :delete_article, user, article),
             {:ok, %Article{}} <- API.delete_article id do
                send_resp(conn, :no_content, "")
        end 
    end

    def create(conn, %{"article" => article}) do
        user = Guardian.Plug.current_resource(conn)
        article = Map.put(article, "author_id", user.id)
        with {:ok, %Article{} = article} <- API.create_article(article) do
            conn
              |> put_status(:created)
              |> render("show.json", article: article)
        end
    end
end