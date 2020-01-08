defmodule BookshelfWeb.ProfileController do
  use BookshelfWeb, :controller

  alias Bookshelf.{Accounts, Accounts.Account}

  def show(conn, _params) do
    case conn.assigns.session_account do
      nil ->
        conn
        |> put_flash(:info, "Please sign in to access your profile")
        |> render("login.html")

      account ->
        render(conn, "profile.html", account: account, changeset: Accounts.change_account(%Account{}))
    end
  end

  def auth(conn, %{"username" => username, "airtable_api_key" => airtable_api_key}) do
    case Accounts.get_account_by(username: username) do
      %{id: id, airtable_api_key: ^airtable_api_key} ->
        conn
        |> put_session(:account_id, id)
        |> redirect(to: Routes.profile_path(conn, :show))

      _otherwise ->
        conn
        |> put_flash(:error, "Invalid username or password")
        |> redirect(to: Routes.profile_path(conn, :show))
    end
  end

  def update(conn, %{"account" => attrs}) do
    attrs = attrs
    |> Map.to_list()
    |> Enum.filter(fn {_key, value} -> value != "" end)
    |> Map.new()

    case Accounts.update_account(conn.assigns.session_account, attrs) do
      {:ok, _account} ->
        conn
        |> put_flash(:info, "Updated profile")
        |> redirect(to: Routes.profile_path(conn, :show))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "profile.html", account: conn.assigns.session_account, changeset: changeset)
    end
  end

  def logout(conn, _params) do
    conn
    |> clear_session()
    |> put_flash(:info, "You were successfully logged out.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
