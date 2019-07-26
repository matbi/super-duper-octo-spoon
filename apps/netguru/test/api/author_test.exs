defmodule Netguru.API.AuthorTest do
    use Netguru.DataCase
    alias Netguru.API.Author, as: API
    alias Netguru.Schema.Author

    describe "get_author!/1" do
        test "returns the given author" do
            assert %Author{id: 1} = API.get_author!(1)
        end

        test "raises an error when not found" do
            assert_raise Ecto.NoResultsError, fn ->
                API.get_author! 2
            end
        end
    end
end