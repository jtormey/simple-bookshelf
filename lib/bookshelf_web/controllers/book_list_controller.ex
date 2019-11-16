defmodule BookshelfWeb.BookListController do
  use BookshelfWeb, :controller

  require Logger

  alias Bookshelf.{Accounts, AirtableApi, AirtableValidator}

  @table_name "Books"

  def index(conn, %{"username" => username}) do
    case Accounts.get_account_by(username: username) do
      nil ->
        conn
        |> put_flash(:info, "There is no account with username \"#{username}\".")
        |> render("not_found.html")

      account ->
        with {:ok, books} <- AirtableApi.get_records!(@table_name, account),
             {:ok, books} <- AirtableValidator.check(books)
        do
          sections = Enum.group_by books, fn record ->
            get_in(record, ["fields", "Status"])
          end
          render(conn, "index.html", account: account, sections: sections)

        else
          {:error, :no_records} ->
            conn
            |> put_flash(:info, "This user hasn't added any books to their list yet!")
            |> render("index.html", account: account, sections: [])

          {:error, reason} ->
            Logger.warn("AirtableApi failed with reason: #{inspect(reason)}")

            conn
            |> put_flash(:error, "Failed to connect to Airtable! Did you enter your Airtable API key and base correctly?")
            |> render("index.html", account: account, sections: [])
        end
    end
  end
end
