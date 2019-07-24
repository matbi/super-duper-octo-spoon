defmodule Netguru.Schema.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias Netguru.Schema

  @all_fields [:first_name, :last_name, :age]
  @required_fields @all_fields

  schema "authors" do
    field :age, :integer
    field :first_name, :string
    field :last_name, :string

    has_many :articles, Schema.Article

    timestamps()
  end

  def changeset(author, attrs) do
    author
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
    |> validate_number(:age, greater_than_or_equal_to: 13)
  end

  def all_fields, do: @all_fields
end
