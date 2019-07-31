defmodule NetguruWeb.Policies.Article do
    @behaviour Bodyguard.Policy
    @moduledoc false
    alias Netguru.Schema.{Article, Author}

    def authorize(:delete_article, %Author{id: user_id}, %Article{author_id: author_id}) do
        user_id == author_id
    end
end