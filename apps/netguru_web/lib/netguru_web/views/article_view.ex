defmodule NetguruWeb.ArticleView do
    use NetguruWeb, :view

    def render("show.json", %{article: article}) do
        %{
            id: article.id,
            body: article.body,
            description: article.description,
            published_date: article.published_date,
            title: article.title,
        }
    end

    def render("show_with_author.json", %{article: article}) do
        "show.json"
            |> render(%{article: article})
            |> Map.put(:author, render_one(article.author, NetguruWeb.AuthorView, "show.json", as: :author))
    end

    def render("index.json", %{articles: articles}) do
        %{
            articles: render_many(articles, __MODULE__, "show_with_author.json", as: :article)
        }
    end
  end
  