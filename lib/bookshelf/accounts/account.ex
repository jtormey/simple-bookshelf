defmodule Bookshelf.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "accounts" do
    field :airtable_api_key, :string
    field :airtable_base, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:username, :airtable_api_key, :airtable_base])
    |> validate_required([:username, :airtable_api_key, :airtable_base])
    |> unique_constraint(:username)
  end
end
