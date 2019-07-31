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

    describe "update_author/2" do
        test "should return an error when the author doesn't exist" do
            assert {:error, :not_found} = API.update_author(2, %{"age" => 13})
        end

        test "should return an error when the data is invalid" do
            assert {:error, %Ecto.Changeset{valid?: false}} = API.update_author(1, %{"age" => 10})
        end

        test "should update the author when the data is valid" do
            assert {:ok, %Author{id: 1, age: 100}} = API.update_author(1, %{"age" => 100})
            assert %Author{id: 1, age: 100} = API.get_author!(1)
        end
    end
end