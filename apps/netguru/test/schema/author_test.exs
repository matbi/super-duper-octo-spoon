defmodule Netguru.Schema.AuthorTest do
    use Netguru.DataCase
    alias Netguru.Schema.Author

    setup do
        valid_author = 
            Author
                |> Repo.get!(1)
                |> Map.take(Author.all_fields)

        {:ok, valid_author: valid_author}
    end

    test "valid_author is valid", %{valid_author: author} do
        changeset = changeset_merge(author, %{})

        assert changeset.valid?
    end

    test "first_name is required", %{ valid_author: author } do
        changeset = changeset_merge(author, %{first_name: ""})

        refute changeset.valid?
        assert Keyword.has_key? changeset.errors, :first_name
    end

    test "last_name is required", %{ valid_author: author } do
        changeset = changeset_merge(author, %{last_name: ""})

        refute changeset.valid?
        assert Keyword.has_key? changeset.errors, :last_name
    end

    describe "age" do
        test "is invalid when under 13", %{ valid_author: author } do
            age = Enum.random(-10..12)
            changeset = changeset_merge(author, %{age: age})
            
            refute changeset.valid?
            assert Keyword.has_key? changeset.errors, :age
        end

        test "is valid when over 13 or equal to it", %{ valid_author: author } do
            age = Enum.random(13..100)
            changeset = changeset_merge(author, %{age: age})

            assert changeset.valid?
        end

        test "is required", %{ valid_author: author } do
            changeset = changeset_merge(author, %{age: ""})

            refute changeset.valid?
            assert Keyword.has_key? changeset.errors, :age
        end
    end

    defp changeset_merge(author, params) do
        Author.changeset(%Author{}, Map.merge(author, params))
    end

end