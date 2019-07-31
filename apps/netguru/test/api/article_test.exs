defmodule Netguru.API.ArticleTest do
    use Netguru.DataCase
    alias Netguru.API.Article, as: API
    alias Netguru.Schema.Article

    describe "delete_article/1" do
        test "should delete an existing article" do
            assert %Article{id: 1} = API.get_article!(1)

            API.delete_article 1

            assert_raise Ecto.NoResultsError, fn -> API.get_article!(1) end
        end

        test "should return an error for an article that doesn't exist" do
            assert {:error, :not_found} = API.delete_article 2
        end
    end
end