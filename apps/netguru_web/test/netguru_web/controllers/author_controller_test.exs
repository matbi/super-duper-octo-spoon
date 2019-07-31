defmodule NetguruWeb.AuthorControllerTest do
    use NetguruWeb.ConnCase

    describe "show/2" do
        test "should return 404 when the author doesn't exist", %{conn: conn} do
            assert_error_sent :not_found, fn ->
                get conn, author_path(conn, :show, 2)
            end
        end

        test "should return the author's details when the author exists", %{conn: conn} do
            conn = get conn, author_path(conn, :show, 1)

            assert %{
                "id" => 1,
                "first_name" => "Jan",
                "last_name" => "Kowalski",
                "age" => 18
            } == json_response(conn, 200)
        end

        test "shouldn't be accessible without authentication" do
            conn = build_conn()
            conn = get conn, author_path(conn, :show, 1)

            assert conn.status == 401
        end
    end

    describe "create/2" do
        test "should be accessible without authentication" do
            conn = build_conn()
            conn = post conn, author_path(conn, :create, %{"author" => %{"age" => 10}})

            # Not 401 - not authenticated but 422 - wrong changeset
            _ = json_response(conn, 422)
        end

        test "should return a token when the author has been created" do
            author = %{
                "age" => 18,
                "first_name" => "Jan",
                "last_name" => "Kowalski"
            }

            conn = build_conn()
            conn = post conn, author_path(conn, :create, %{"author" => author})

            assert %{"token" => token} = json_response(conn, 201)
            {:ok, %{"sub" => author_id}} = NetguruWeb.Guardian.decode_and_verify(token)

            _author = Netguru.API.Author.get_author! author_id
        end

        test "should return an error when the author is invalid" do
            author = %{
                "age" => 1
            }

            conn = build_conn()
            conn = post conn, author_path(conn, :create, %{"author" => author})

            assert %{"errors" => _} = json_response(conn, 422)
        end

        test "shouldn't create any article when the data is invalid" do
            articles_length = length(Netguru.API.Article.index_articles())

            author = %{
                "age" => 1
            }

            conn = build_conn()
            _conn = post conn, author_path(conn, :create, %{"author" => author})

            assert length(Netguru.API.Article.index_articles()) == articles_length
        end
    end

    describe "update/2" do
        test "shouldn't be accessible for an unauthenticated user" do
            author = %{
                "age" => 18,
                "first_name" => "Jan",
                "last_name" => "Kowalski"
            }

            conn = build_conn()
            conn = put conn, author_path(conn, :update, 1, %{"author" => author})

            assert conn.status == 401
        end

        test "should update the given author", %{conn: conn} do
            author = %{
                "age" => 13,
                "first_name" => "Test",
                "last_name" => "Test2"
            }

            conn = put conn, author_path(conn, :update, 1, %{"author" => author})
            response = json_response(conn, 200)

            author
                |> Map.keys()
                |> Enum.each(&(assert(author[&1] == response[&1], "#{&1} is different, request: #{author[&1]}, response: #{response[&1]}")))
        end

        test "should return a 404 when the author doesn't exist", %{conn: conn} do
            author = %{
                "age" => 13,
                "first_name" => "Test",
                "last_name" => "Test2"
            }

            assert_error_sent :not_found, fn ->
                put conn, author_path(conn, :update, 2, %{"author" => author})
            end
        end

        test "should return an error when the data is invalid", %{conn: conn} do
            author = %{
                "age" => 10
            }

            conn = put conn, author_path(conn, :update, 1, %{"author" => author})
            response = json_response(conn, 422)

            assert Map.has_key?(response, "errors")
        end

        test "shouldn't be accessible for another user" do
            author = %{
                "age" => 13,
                "first_name" => "Test",
                "last_name" => "Test2"
            }

            {:ok, %Netguru.Schema.Author{} = author} = Netguru.API.Author.create_author(author)
            conn = login(author.id)
            conn = put conn, author_path(conn, :update, 1, %{"author" => author})

            assert conn.status == 401
        end
    end
end
  