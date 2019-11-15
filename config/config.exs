# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bookshelf,
  ecto_repos: [Bookshelf.Repo]

# Configures the endpoint
config :bookshelf, BookshelfWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SKXsmUQ2pYUPipC9nwU7EsxeSj7DA11G0fPxK3Kp8ntTFsm931donKS79u/V+u+N",
  render_errors: [view: BookshelfWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bookshelf.PubSub, adapter: Phoenix.PubSub.PG2]

config :bookshelf, BookshelfWeb.Admin,
  username: "admin",
  password: "password",
  realm: "Simple Bookshelf"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
