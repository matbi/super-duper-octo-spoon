defmodule NetguruWeb.ArticleController do
    use NetguruWeb, :controller

    alias Netguru.Schema.Article
    alias Netguru.API.Article, as: API

    def delete(conn, %{"id" => id}) do
        article = API.get_article! id

        with {:ok, %Article{}} <- API.delete_article article do
            send_resp(conn, :no_content, "")
        end
    end
end