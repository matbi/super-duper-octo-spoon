defmodule NetguruWeb.ArticleControllerTest do
    use NetguruWeb.ConnCase
  
    describe "delete/2" do
        test "should return 404 when the article not found", %{conn: conn} do
            assert_error_sent :not_found, fn ->
                delete conn, article_path(conn, :delete, 2)
            end
        end

        test "should return 204 when the article was found", %{conn: conn} do
            conn = delete conn, article_path(conn, :delete, 1)
            assert response(conn, 204)
        end
    end

    describe "create/2" do
        test "should create a new article", %{conn: conn} do
            article = %{
                "body" => "body",
                "description" => "foo bar",
                "title" => "title"
            }

            conn = post conn, article_path(conn, :create, %{"article" => article})
            response = json_response(conn, 201)

            article
                |> Map.keys()
                |> Enum.each(&(assert(article[&1] == response[&1], "#{&1} is different, request: #{article[&1]}, response: #{response[&1]}")))

            # shouldn't raise when the article exists
            _article = Netguru.API.Article.get_article!(response["id"])
        end

        test "should return changeset errors when the article is invalid", %{conn: conn} do
            article = %{
                "body" => ""
            }
            conn = post conn, article_path(conn, :create, %{"article" => article})

            response = json_response(conn, 422)
            assert %{"errors" => %{
                "body" => ["can't be blank"],
                "title" => ["can't be blank"]
            }} = response
        end
    end
  end
  