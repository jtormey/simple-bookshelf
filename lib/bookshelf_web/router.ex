defmodule BookshelfWeb.Router do
  use BookshelfWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plugs.AccountSession
  end

  pipeline :admin_browser do
    plug :put_layout, {BookshelfWeb.LayoutView, "admin.html"}
    plug BasicAuth, use_config: {:bookshelf, BookshelfWeb.Admin}
  end

  scope "/", BookshelfWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/signup", PageController, :signup
    get "/u/:username", BookListController, :index

    scope "/profile" do
      get "/", ProfileController, :show
      post "/login", ProfileController, :auth
      post "/", ProfileController, :update
      get "/logout", ProfileController, :logout
    end
  end

  scope "/~/admin", BookshelfWeb do
    pipe_through :browser
    pipe_through :admin_browser

    resources "/accounts", AccountController
  end
end
