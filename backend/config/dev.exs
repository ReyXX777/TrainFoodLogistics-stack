use Mix.Config

# Configure the database for the development environment
config :train_food_logistics, TrainFoodLogistics.Repo,
  username: "postgres",               # Database username
  password: "postgres",               # Database password
  database: "train_food_logistics_dev", # Development database name
  hostname: "localhost",              # Database host
  show_sensitive_data_on_connection_error: true,
  pool_size: 10                       # Number of connections in the pool

# Configure the endpoint for development
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  http: [port: 4000],                 # HTTP port for the development server
  debug_errors: true,                 # Enables debug errors for better error reporting
  code_reloader: true,                # Enables code reloading during development
  check_origin: false,                # Disables origin checking for local development
  watchers: [                         # Configures watchers to run external tools
    node: ["node_modules/webpack/bin/webpack.js", "--mode", "development",
      cd: Path.expand("../assets", __DIR__)]
  ]

# Configures live reload for static and templates
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$", # Watch for changes in static assets
      ~r"priv/gettext/.*(po)$",                         # Watch for changes in gettext files
      ~r"lib/train_food_logistics_web/(live|views)/.*(ex)$", # Watch for changes in live views and templates
      ~r"lib/train_food_logistics_web/templates/.*(eex)$"    # Watch for changes in EEx templates
    ]
  ]

# Configure logger for development
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Enable stacktraces for better debugging during development
config :phoenix, :stacktrace_depth, 20

# Enable development routes for debugging tools
config :train_food_logistics, dev_routes: true

# Redis configuration for caching in development
config :redix,
  host: "localhost",
  port: 6379

# Email delivery configuration for development
config :train_food_logistics, TrainFoodLogistics.Mailer,
  adapter: Swoosh.Adapters.Local # Local adapter to view emails in the browser

# SMS service configuration for development
config :train_food_logistics, :sms_service,
  service: "twilio",            # SMS service provider
  account_sid: "your_dev_sid",  # Development Twilio SID
  auth_token: "your_dev_token"  # Development Twilio auth token
