defmodule Bookshelf.AirtableValidator do
  @valid_statuses [
    "Not Started",
    "Currently Reading",
    "Finished",
    "Set Aside"
  ]

  def check([]) do
    {:error, :no_records}
  end

  def check(records) do
    {:ok, Enum.filter(records, &validate/1)}
  end

  def validate(%{"fields" => %{"Name" => _, "Status" => status}}) do
    Enum.find(@valid_statuses, fn s -> s == status end) != nil
  end

  def validate(_otherwise), do: false
end
