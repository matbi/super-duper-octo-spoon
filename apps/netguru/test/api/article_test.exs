defmodule Netguru.API.ArticleTest do
    use Netguru.DataCase
    alias Netguru.API.Article, as: API
    alias Netguru.Schema.Article

    describe "delete_article/1" do
        test "should delete an existing article" do
            assert %Article{id: 1} = article = API.get_article!(1)

            API.delete_article article

            assert_raise Ecto.NoResultsError, fn -> API.get_article!(1) end
        end
    end
end