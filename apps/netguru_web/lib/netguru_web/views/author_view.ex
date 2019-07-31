defmodule NetguruWeb.AuthorView do
    use NetguruWeb, :view

    def render("show.json", %{author: author}) do
        %{
            id: author.id,
            first_name: author.first_name,
            last_name: author.last_name,
            age: author.age
        }
    end
  end
  