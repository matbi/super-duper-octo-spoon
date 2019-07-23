defmodule Netguru.Schema.Article do
  use Ecto.Schema
  import Ecto.Changeset
  alias Netguru.Schema


  schema "articles" do
    field :body, :string
    field :description, :string
    field :published_date, :naive_datetime
    field :title, :string
    
    belongs_to :author, Schema.Author

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :description, :body, :published_date])
    |> validate_required([:title, :description, :body, :published_date])
  end
end
