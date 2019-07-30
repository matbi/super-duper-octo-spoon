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

    describe "create_author/1" do
        @author %{
            first_name: "name",
            last_name: "name",
            age: 18
        }

        test "creates a new author when the author is valid" do
            {:ok, %Author{id: id} = author} = API.create_author(@author)

            assert ^author = Repo.get(Author, id)
        end

        test "returns an error when the author is invalid" do
            invalid_author = Map.delete(@author, :age)
            assert {:error, %Ecto.Changeset{valid?: false, errors: errors}} = API.create_author(invalid_author)
        end
    end
end