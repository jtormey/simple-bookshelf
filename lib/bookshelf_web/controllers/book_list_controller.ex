defmodule BookshelfWeb.BookListController do
  use BookshelfWeb, :controller

  require Logger

  alias Bookshelf.{Accounts, AirtableApi}

  def index(conn, %{"username" => username}) do
    case Accounts.get_account_by(username: username) do
      nil ->
        conn
        |> put_flash(:info, "There is no account with username \"#{username}\".")
        |> render("not_found.html")

      account ->
        case AirtableApi.get_records!("Books", account) do
          {:ok, books} ->
            sections = Enum.group_by books, fn record ->
              get_in(record, ["fields", "Status"])
            end

            render(conn, "index.html", account: account, sections: sections)

          {:error, reason} ->
            Logger.warn("AirtableApi failed with reason: #{inspect(reason)}")

            conn
            |> put_flash(:error, "Failed to connect to Airtable! Did you enter your Airtable API key and base correctly?")
            |> render("index.html", account: account, sections: [])
        end

    end
  end
end
