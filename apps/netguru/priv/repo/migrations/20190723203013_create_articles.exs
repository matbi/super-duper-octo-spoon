defmodule Netguru.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :description, :string
      add :body, :string
      add :published_date, :naive_datetime
      add :author_id, references(:authors, on_delete: :nothing)

      timestamps()
    end

    create index(:articles, [:author_id])
  end
end
