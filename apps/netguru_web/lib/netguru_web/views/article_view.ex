defmodule NetguruWeb.ArticleView do
    use NetguruWeb, :view

    def render("show.json", %{ article: article }) do
        %{
            id: article.id,
            body: article.body,
            description: article[:description],
            published_date: article.published_date,
            title: article.title,
        }
    end
  end
  