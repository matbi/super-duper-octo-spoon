defmodule Netguru.API.ArticleTest do
    use Netguru.DataCase
    alias Netguru.API.Article, as: API
    alias Netguru.Schema.Article

    describe "delete_article/1" do
        test "should delete an existing article" do
            assert %Article{id: 1} = API.get_article!(1)

            {:ok, %Article{}} = API.delete_article 1

            assert_raise Ecto.NoResultsError, fn -> API.get_article!(1) end
        end

        test "should return an error for an article that doesn't exist" do
            assert {:error, :not_found} = API.delete_article 2
        end
    end

    describe "get_article!/1" do
        test "should return the existing article" do
            assert %Article{id: 1} = API.get_article! 1
        end

        test "should raise when the article doesn't exist" do
            assert_raise Ecto.NoResultsError, fn -> API.get_article! 2 end
        end
    end

    describe "create_article/1" do
        @article %{
            "description" => "desc",
            "title" => "title",
            "author_id" => 1,
            "body" => "body"
        }

        test "should create an article when the data is valid" do
            assert {:ok, %Article{id: id} = article} = API.create_article(@article)
            assert ^article = API.get_article!(id)
        end

        test "should return an error when the data is invalid" do
            invalid_article = Map.delete(@article, "body")
            assert {:error, %Ecto.Changeset{valid?: false}} = API.create_article(invalid_article)
        end
    end

    describe "index_articles/1" do
        test "should return the whole list of articles" do
            assert length(Repo.all(Article)) == length(API.index_articles())
        end

        test "shouldn't preload the author when not stated explicitly" do
            articles = API.index_articles()
            article = List.first(articles)

            assert %{author: %Ecto.Association.NotLoaded{}} = article
        end

        test "should preload the author when stated explicitly" do
            articles = API.index_articles(preload: true)
            article = List.first(articles)

            assert %{author: %{id: 1}} = article
        end
    end
end