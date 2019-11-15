use Mix.Config

# Configure Endpoint
config :bookshelf, BookshelfWeb.Endpoint,
  http: [port: 4000],
  url: [host: "localhost"],
  secret_key_base: "SKXsmUQ2pYUPipC9nwU7EsxeSj7DA11G0fPxK3Kp8ntTFsm931donKS79u/V+u+N",
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Configure Admin Login
config :bookshelf, BookshelfWeb.Admin,
  username: "admin",
  password: "password",
  realm: "Simple Bookshelf (dev)"

# Configure Endpoint (live reload)
config :bookshelf, BookshelfWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/bookshelf_web/views/.*(ex)$},
      ~r{lib/bookshelf_web/templates/.*(eex)$}
    ]
  ]

# Configure Phoenix (for development)
config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

# Configure Postgres
config :bookshelf, Bookshelf.Repo,
  username: "justin",
  database: "bookshelf_dev",
  hostname: "localhost",
  pool_size: 10
