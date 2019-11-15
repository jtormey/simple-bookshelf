defmodule Bookshelf.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "accounts" do
    field :username, :string
    field :name, :string
    field :airtable_api_key, :string
    field :airtable_base, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:username, :name, :airtable_api_key, :airtable_base])
    |> validate_required([:username, :name, :airtable_api_key, :airtable_base])
    |> unique_constraint(:username)
  end
end
