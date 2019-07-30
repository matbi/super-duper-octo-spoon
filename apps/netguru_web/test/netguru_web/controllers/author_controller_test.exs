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
                "last_name" => "Kowalski"
            } == json_response(conn, 200)
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
    end
end
  