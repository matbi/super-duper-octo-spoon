defmodule NetguruWeb.ArticleControllerTest do
    use NetguruWeb.ConnCase
  
    describe "delete/2" do
        test "should return 404 when the article not found", %{conn: conn} do
            assert_error_sent :not_found, fn ->
                delete conn, article_path(conn, :delete, 2)
            end
        end

        test "should return 204 when the article was found and deleted", %{conn: conn} do
            conn = delete conn, article_path(conn, :delete, 1)
            assert response(conn, 204)

            assert_raise Ecto.NoResultsError, fn ->
                Netguru.API.Article.get_article!(1)
            end
        end

        test "shouldn't be accessible for an unauthenticated user" do
            conn = build_conn()
            conn = delete conn, article_path(conn, :delete, 1)
            assert conn.status == 401
        end

        test "shouldn't be accessible for a user that is not the author" do
            author = %{
                "age" => 13,
                "first_name" => "Test",
                "last_name" => "Test2"
            }
            {:ok, %Netguru.Schema.Author{} = author} = Netguru.API.Author.create_author(author)
            conn = login(author.id)
            conn = delete conn, article_path(conn, :delete, 1)

            assert conn.status == 401

            # shouldn't raise
            _article = Netguru.API.Article.get_article!(1)
        end
    end

    describe "create/2" do
        @article %{
            "body" => "body",
            "description" => "foo bar",
            "title" => "title"
        }

        test "should create a new article", %{conn: conn} do
            conn = post conn, article_path(conn, :create, %{"article" => @article})
            response = json_response(conn, 201)

            @article
                |> Map.keys()
                |> Enum.each(&(assert(@article[&1] == response[&1], "#{&1} is different, request: #{@article[&1]}, response: #{response[&1]}")))

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

        test "shouldn't be accessible for an unautenticated user" do
            conn = build_conn()
            conn = post conn, article_path(conn, :create, %{"article" => @article})
            assert conn.status == 401
        end
    end

    describe "index/2" do
        test "shouldn't be accessible for an unauthenticated user" do
            conn = build_conn()
            conn = get conn, article_path(conn, :index)

            assert conn.status == 401
        end

        test "should return a list of articles", %{conn: conn} do
            conn = get conn, article_path(conn, :index)

            %{"articles" => articles} = json_response(conn, 200)
            assert length(articles) == 1
        end

        test "should preload the author", %{conn: conn} do
            conn = get conn, article_path(conn, :index)
            %{"articles" => articles} = json_response(conn, 200)

            author = Netguru.API.Author.get_author!(1)
            author = "show.json"
                        |> NetguruWeb.AuthorView.render(%{author: author})
                        |> Map.new(fn {key, value} -> {to_string(key), value} end)

            assert %{
                "author" => ^author
            } = List.first(articles)
        end
    end
  end
  