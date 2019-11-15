defmodule BookshelfWeb.BookListController do
  use BookshelfWeb, :controller

  alias Bookshelf.Accounts

  def index(conn, %{"username" => username}) do
    case Accounts.get_account_by(username: username) do
      nil ->
        render(conn, "not_found.html", username: username)
      account ->
        render(conn, "index.html", account: account)
    end
  end
end
