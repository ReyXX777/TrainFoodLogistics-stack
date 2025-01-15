use Mix.Config

# Configure the application and environment settings
config :train_food_logistics,
  ecto_repos: [TrainFoodLogistics.Repo]  # Specify the repository for Ecto

# Configure the database for the development environment
config :train_food_logistics, TrainFoodLogistics.Repo,
  username: "postgres",                # Database username
  password: "postgres",                # Database password
  database: "train_food_logistics_dev", # Development database name
  hostname: "localhost",               # Database host
  pool_size: 10,                       # Number of connections in the pool
  show_sensitive_data_on_connection_error: true

# Configure the endpoint for the development environment
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  http: [port: 4000],  # HTTP port
  debug_errors: true,  # Enable detailed errors in development
  code_reloader: true, # Automatically reload code on changes
  check_origin: false, # Disable origin checking for local development
  watchers: [
    node: ["node_modules/webpack/bin/webpack.js", "--mode", "development", cd: Path.expand("../assets", __DIR__)]
  ]

# Configure live reload for static assets, templates, and views
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$", # Watch for changes in static files
      ~r"priv/gettext/.*(po)$",                         # Watch for changes in gettext files
      ~r"lib/train_food_logistics_web/(live|views)/.*(ex)$", # Watch for changes in live views and templates
      ~r"lib/train_food_logistics_web/templates/.*(eex)$"    # Watch for changes in templates
    ]
  ]

# Logger configuration for better debugging in development
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure the stacktrace depth for debugging
config :phoenix, :stacktrace_depth, 20

# Enable development routes for debugging tools
config :train_food_logistics, dev_routes: true

# Redis configuration for caching in development
config :redix,
  host: "localhost",
  port: 6379

# Email delivery configuration for development
config :train_food_logistics, TrainFoodLogistics.Mailer,
  adapter: Swoosh.Adapters.Local # Use the local adapter to view emails in the browser during development

# SMS service configuration for development
config :train_food_logistics, :sms_service,
  service: "twilio",           # Specify SMS provider (e.g., Twilio)
  account_sid: "your_dev_sid", # Development Twilio SID
  auth_token: "your_dev_token" # Development Twilio auth token

# Configure the production environment
config :train_food_logistics, TrainFoodLogistics.Repo,
  username: System.get_env("DB_USERNAME") || "postgres",         # Use environment variables for credentials
  password: System.get_env("DB_PASSWORD") || "postgres",         # Default value for local fallback
  database: System.get_env("DB_NAME") || "train_food_logistics_prod", # Production database name
  hostname: System.get_env("DB_HOST") || "localhost",            # Database host
  pool_size: String.to_integer(System.get_env("DB_POOL_SIZE") || "15"), # Configurable pool size
  ssl: true                                                      # Enable SSL for secure connections

# Configure the endpoint for production
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),   # Port configured via environment variable
    transport_options: [socket_opts: [:inet6]]                  # Enable IPv6
  ],
  url: [
    scheme: "https",                                             # Use HTTPS in production
    host: System.get_env("HOST") || "example.com",               # Public-facing hostname
    port: 443                                                    # HTTPS port
  ],
  cache_static_manifest: "priv/static/cache_manifest.json",      # Cache static files for production
  secret_key_base: System.get_env("SECRET_KEY_BASE")             # Secret key for session encryption

# Force SSL in production for secure communication
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  force_ssl: [rewrite_on: [:x_forwarded_proto]]

# Logger configuration for production (no debug or info logs)
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Redis configuration for production
config :redix,
  host: System.get_env("REDIS_HOST") || "localhost",             # Redis host
  port: String.to_integer(System.get_env("REDIS_PORT") || "6379") # Redis port

# Email configuration for production using SMTP
config :train_food_logistics, TrainFoodLogistics.Mailer,
  adapter: Swoosh.Adapters.SMTP,                                 # Use SMTP adapter for production
  relay: System.get_env("SMTP_RELAY"),                           # SMTP server
  username: System.get_env("SMTP_USERNAME"),                     # SMTP username
  password: System.get_env("SMTP_PASSWORD"),                     # SMTP password
  ssl: true,                                                     # Enable SSL for email
  tls: :if_available,                                            # Enable TLS if supported
  port: 587                                                      # SMTP port

# SMS service configuration for production using Twilio
config :train_food_logistics, :sms_service,
  service: "twilio",                                             # Twilio as SMS service
  account_sid: System.get_env("TWILIO_ACCOUNT_SID"),             # Twilio account SID
  auth_token: System.get_env("TWILIO_AUTH_TOKEN")                # Twilio auth token

# Runtime configuration for releases
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  server: true                                                   # Ensure the server is started in production
