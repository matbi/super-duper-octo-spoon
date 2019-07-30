defmodule NetguruWeb.ArticleController do
    use NetguruWeb, :controller

    alias Netguru.Schema.Article
    alias Netguru.API.Article, as: API

    action_fallback NetguruWeb.FallbackController

    def delete(conn, %{"id" => id}) do
        article = API.get_article! id

        with {:ok, %Article{}} <- API.delete_article article do
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