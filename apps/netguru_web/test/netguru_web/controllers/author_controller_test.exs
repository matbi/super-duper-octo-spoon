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
end
  