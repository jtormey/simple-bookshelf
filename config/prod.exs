use Mix.Config

config :bookshelf, BookshelfWeb.Endpoint,
  http: [:inet6, port: System.get_env("PORT") || 4000],
  url: [scheme: "https", host: "digitalocean.simplebookshelf.com", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  code_reloader: false

config :logger, level: :info

import_config "prod.secret.exs"
