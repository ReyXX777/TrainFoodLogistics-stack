# This file is responsible for configuring your application
# and its dependencies with the help of the Mix.Config module.

use Mix.Config

# General application configuration
config :train_food_logistics,
  ecto_repos: [TrainFoodLogistics.Repo],  # Specifies the Ecto repository for database operations

# Configures the endpoint
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  url: [host: "localhost"],               # Base URL for the application
  secret_key_base: "your_secret_key",     # Secret key for encrypting session data
  render_errors: [view: TrainFoodLogisticsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TrainFoodLogistics.PubSub,
  live_view: [signing_salt: "your_signing_salt"] # Salt for LiveView session signing

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n", # Logger output format
  metadata: [:request_id]                       # Metadata to include in logs

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure the database
config :train_food_logistics, TrainFoodLogistics.Repo,
  username: "postgres",               # Database username
  password: "postgres",               # Database password
  database: "train_food_logistics_dev", # Development database name
  hostname: "localhost",              # Database host
  show_sensitive_data_on_connection_error: true,
  pool_size: 10                       # Number of database connections in the pool

# Redis configuration (if caching is used)
config :redix,
  host: "localhost", # Redis server hostname
  port: 6379         # Redis server port

# Email configuration
config :train_food_logistics, TrainFoodLogistics.Mailer,
  adapter: Swoosh.Adapters.Local # Local adapter for development

# SMS Service configuration
config :train_food_logistics, :sms_service,
  service: "twilio",  # SMS service provider
  account_sid: "your_account_sid", # Twilio account SID
  auth_token: "your_auth_token",   # Twilio auth token

# Import environment-specific config (dev, test, prod)
import_config "#{Mix.env()}.exs"
