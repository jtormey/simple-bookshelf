defmodule Bookshelf.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :username, :string, null: false
      add :name, :string
      add :airtable_api_key, :string
      add :airtable_base, :string

      timestamps()
    end

    create index("accounts", [:username], unique: true)
  end
end
