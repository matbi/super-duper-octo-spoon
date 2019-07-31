defmodule Netguru.Schema.ArticleTest do
    use Netguru.DataCase
    alias Netguru.Schema.Article

    setup do
        valid_article = 
            Article
                |> Repo.get!(1)
                |> Map.take(Article.all_fields)

        {:ok, valid_article: valid_article}
    end

    # To ensure that no tests pass/fail because of invalid "basic" article data
    test "valid_article is valid", %{valid_article: article} do
        changeset = changeset_merge(article, %{})
        assert changeset.valid?
    end

    test "body is required", %{valid_article: article} do
        changeset = changeset_merge(article, %{body: ""})
        
        refute changeset.valid?
        assert Keyword.has_key? changeset.errors, :body
    end

    test "published_date is required", %{valid_article: article} do
        changeset = changeset_merge(article, %{published_date: ""})

        refute changeset.valid?
        assert Keyword.has_key? changeset.errors, :published_date
    end

    test "description isn't required", %{valid_article: article} do
        changeset = changeset_merge(article, %{description: ""})

        assert changeset.valid?
    end

    describe "title" do
        test "is required", %{valid_article: article} do
            changeset = changeset_merge(article, %{title: ""})
    
            refute changeset.valid?
            assert Keyword.has_key? changeset.errors, :title
        end

        test "length cannot exceed 150 characters", %{valid_article: article} do
            length = 150 + Enum.random(1..100)
            title = generate_title(length)

            changeset = changeset_merge(article, %{title: title})

            refute changeset.valid?
            assert Keyword.has_key? changeset.errors, :title
        end

        test "is valid when the length doesn't exceed 150 characters", %{valid_article: article} do
            length = Enum.random(1..149)
            title = generate_title(length)

            changeset = changeset_merge(article, %{title: title})

            assert changeset.valid?
        end

        defp generate_title(length) when is_integer(length) do
            length
                |> :crypto.strong_rand_bytes()
                |> Base.encode64()
                |> binary_part(0, length)
        end
    end

    test "author_id is required", %{valid_article: article} do
        changeset = changeset_merge(article, %{author_id: ""})

        refute changeset.valid?
        assert Keyword.has_key? changeset.errors, :author_id
    end

    defp changeset_merge(article, params) do
        Article.changeset(%Article{}, Map.merge(article, params))
    end

end