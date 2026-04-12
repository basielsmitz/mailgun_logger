import Config

port = String.to_integer(System.get_env("PORT") || "5050")

config :mailgun_logger, MailgunLoggerWeb.Endpoint,
  url: [
    host: System.get_env("HOST", "localhost"),
    scheme: "http",
    port: port
  ],
  http: [
    ip: {0, 0, 0, 0},
    port: port
  ],
  live_reload: [
    web_console_logger: true,
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/mailgun_logger_web/(?:controllers|components|lives|views|templates|router)/?.*\.(ex|heex)$}
    ]
  ],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]}
  ],
  secret_key_base: System.get_env("SECRET_KEY_BASE") || "rnd"

config :ex_aws,
  raw_path: "_dev_mailgun_logger/messages"

config :mailgun_logger, MailgunLogger.Scheduler, jobs: []

config :logger, :default_formatter, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20

config :phoenix_live_view,
  debug_heex_annotations: true,
  enable_expensive_runtime_checks: true