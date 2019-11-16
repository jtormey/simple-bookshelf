defmodule Bookshelf.AirtableApi do
  use HTTPoison.Base

  alias Bookshelf.Accounts.Account

  def get_records!(table, account = %Account{}) do
    params = URI.encode_query %{
      "view" => "Grid view",
      "maxRecords" => 100
    }

    headers = [
      "Authorization": "Bearer #{account.airtable_api_key}"
    ]

    try do
      get!("/#{account.airtable_base}/#{table}?#{params}", headers)
      |> handle_response()
    rescue
      _error -> {:error, :failed}
    end
  end

  def handle_response(%HTTPoison.Response{body: body}) do
    case body do
      %{"records" => records} -> {:ok, records}
      %{"error" => error} -> {:error, error}
    end
  end

  def process_request_url(url) do
    "https://api.airtable.com/v0" <> url
  end

  def process_response_body(body) do
    Jason.decode!(body)
  end
end
