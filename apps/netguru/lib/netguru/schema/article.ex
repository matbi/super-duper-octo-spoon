defmodule Netguru.Schema.Article do
  use Ecto.Schema
  import Ecto.Changeset
  alias Netguru.Schema

  @all_fields [:title, :description, :body, :published_date, :author_id]
  @required_fields @all_fields -- [:description]

  schema "articles" do
    field :body, :string
    field :description, :string
    field :published_date, :naive_datetime
    field :title, :string
    
    belongs_to :author, Schema.Author

    timestamps()
  end

  def changeset(article, attrs) do
    article
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
    |> validate_length(:title, max: 150)
  end

  def all_fields, do: @all_fields
end
