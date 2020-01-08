defmodule Plugs.AccountSession do
  import Plug.Conn

  alias Bookshelf.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session(conn, :account_id) do
      nil ->
        assign(conn, :session_account, nil)
      account_id ->
        assign(conn, :session_account, Accounts.get_account(account_id))
    end
  end
end
