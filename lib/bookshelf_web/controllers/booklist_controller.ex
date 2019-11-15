defmodule BookshelfWeb.BookListController do
  use BookshelfWeb, :controller

  alias Bookshelf.{Accounts, AirtableApi}

  def index(conn, %{"username" => username}) do
    case Accounts.get_account_by(username: username) do
      nil ->
        render(conn, "not_found.html", username: username)
      account ->
        {:ok, books} = AirtableApi.get_records!("Books", account)

        categories = Enum.group_by books, fn r -> get_in(r, ["fields", "Status"]) end

        render conn, "index.html", account: account, categories: categories
    end
  end
end
