defmodule Netguru.Schema.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias Netguru.Schema

  @fields [:first_name, :last_name, :age]

  schema "authors" do
    field :age, :integer
    field :first_name, :string
    field :last_name, :string

    has_many :articles, Schema.Article

    timestamps()
  end

  def changeset(author, attrs) do
    author
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_number(:age, greater_than_or_equal_to: 13)
  end
end
