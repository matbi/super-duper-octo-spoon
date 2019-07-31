defmodule Netguru.Seeds do
    @moduledoc false
    def main do
        alias Netguru.Repo
        alias Netguru.Schema.{Article, Author}

        Repo.insert! %Author{
            id: 1,
            first_name: "Jan",
            last_name: "Kowalski",
            age: 18,
        }

        Repo.insert! %Article{
            id: 1,
            title: "Foo bar",
            body: "Foo bar",
            description: "Foo bar",
            published_date: DateTime.utc_now,
            author_id: 1
        }
    end
end