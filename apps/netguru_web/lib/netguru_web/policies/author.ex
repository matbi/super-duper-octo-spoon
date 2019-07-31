defmodule NetguruWeb.Policies.Author do
    alias Netguru.Schema.Author
    @moduledoc """
        Policy for the author controller
    """

    def authorize(:update_author, %Author{id: user_id}, %Author{id: author_id}) do
        user_id == author_id
    end
end