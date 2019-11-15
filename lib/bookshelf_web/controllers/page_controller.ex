defmodule BookshelfWeb.PageController do
  use BookshelfWeb, :controller

  alias Bookshelf.Accounts
  alias Bookshelf.Accounts.Account

  @base_template "https://airtable.com/shr0Z1IOQPeNgeyPR"

  def index(conn, _params) do
    render conn, "index.html",
      changeset: Accounts.change_account(%Account{}),
      base_template: @base_template
  end

  def signup(conn, %{"account" => account_params}) do
    case Accounts.create_account(account_params) do
      {:ok, %Account{username: username}} ->
        conn
        |> put_flash(:info, "Your bookshelf is ready!")
        |> redirect(to: Routes.book_list_path(conn, :index, username))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset, base_template: @base_template)
    end
  end
end
