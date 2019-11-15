defmodule BookshelfWeb.Router do
  use BookshelfWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BookshelfWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/accounts", AccountController
  end
end
