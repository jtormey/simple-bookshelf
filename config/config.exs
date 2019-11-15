use Mix.Config

config :bookshelf,
  ecto_repos: [Bookshelf.Repo]

# Configure Endpoint
config :bookshelf, BookshelfWeb.Endpoint,
  render_errors: [view: BookshelfWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bookshelf.PubSub, adapter: Phoenix.PubSub.PG2]

# Configure Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Phoenix
config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
