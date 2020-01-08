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
    date = Date.from_iso8601!(date)
    if Date.year_of_era(date) == Date.year_of_era(Date.utc_today()) do
      Timex.format!(date, "{Mshort} {D}")
    else
      Timex.format!(date, "{Mshort} {D}, {YYYY}")
    end
  end

  def date_order_field("Currently Reading", %{"Date Started" => started_date}) do
    Date.from_iso8601!(started_date)
  end

  def date_order_field("Finished", %{"Date Finished" => finished_date}) do
    Date.from_iso8601!(finished_date)
  end

  def date_order_field("Set Aside", %{"Date Started" => started_date}) do
    Date.from_iso8601!(started_date)
  end

  def order_section(books, "Not Started"), do: books

  def order_section(books, status) do
    Enum.sort_by(
      books,
      fn book -> date_order_field(status, book["fields"]) end,
      fn date_1, date_2 -> Date.compare(date_1, date_2) != :lt end
    )
  end
end
