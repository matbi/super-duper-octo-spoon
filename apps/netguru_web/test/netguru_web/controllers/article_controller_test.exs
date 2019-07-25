defmodule NetguruWeb.ArticleControllerTest do
    use NetguruWeb.ConnCase
  
    describe "delete" do
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
  end
  