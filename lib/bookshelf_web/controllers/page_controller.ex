defmodule BookshelfWeb.PageController do
  use BookshelfWeb, :controller

  alias Bookshelf.Accounts
  alias Bookshelf.Accounts.Account

  def index(conn, _params) do
    render(conn, "index.html", changeset: Accounts.change_account(%Account{}))
  end

  def signup(conn, %{"account" => account_params}) do
    case Accounts.create_account(account_params) do
      {:ok, %Account{username: username}} ->
        redirect(conn, to: Routes.book_list_path(conn, :index, username))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end
end
