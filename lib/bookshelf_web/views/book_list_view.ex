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
end
