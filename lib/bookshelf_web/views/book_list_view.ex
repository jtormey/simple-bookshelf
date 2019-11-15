defmodule BookshelfWeb.BookListView do
  use BookshelfWeb, :view

  def color_for_status(status) do
    case status do
      "Currently Reading" -> "#FFEAB6"
      "Finished" -> "#C2F5E9"
      "Not Started" -> "#EEEEEE"
      "Set Aside" -> "#FFDCE5"
    end
  end

  def description_for_book("Currently Reading", %{"Date Started" => started_date}) do
    "Started #{date_format(started_date)}"
  end

  def description_for_book("Finished", %{"Date Finished" => finished_date}) do
    "Finished #{date_format(finished_date)}"
  end

  def description_for_book("Set Aside", %{"Date Started" => started_date}) do
    "Started #{date_format(started_date)}"
  end

  def description_for_book(_status, _fields), do: ""

  def date_format(date) do
    date
    |> Date.from_iso8601!()
    |> Timex.format!("{Mshort} {D}")
  end
end
