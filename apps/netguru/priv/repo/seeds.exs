# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Netguru.Repo.insert!(%Netguru.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

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