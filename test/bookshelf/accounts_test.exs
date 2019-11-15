defmodule Bookshelf.AccountsTest do
  use Bookshelf.DataCase

  alias Bookshelf.Accounts

  describe "accounts" do
    alias Bookshelf.Accounts.Account

    @valid_attrs %{airtable_api_key: "some airtable_api_key", airtable_base: "some airtable_base", username: "some username"}
    @update_attrs %{airtable_api_key: "some updated airtable_api_key", airtable_base: "some updated airtable_base", username: "some updated username"}
    @invalid_attrs %{airtable_api_key: nil, airtable_base: nil, username: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Accounts.create_account(@valid_attrs)
      assert account.airtable_api_key == "some airtable_api_key"
      assert account.airtable_base == "some airtable_base"
      assert account.username == "some username"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, %Account{} = account} = Accounts.update_account(account, @update_attrs)
      assert account.airtable_api_key == "some updated airtable_api_key"
      assert account.airtable_base == "some updated airtable_base"
      assert account.username == "some updated username"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end
