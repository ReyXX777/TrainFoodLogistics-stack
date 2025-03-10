# config/config.exs
use Mix.Config

# General application configuration
config :train_food_logistics,
  ecto_repos: [TrainFoodLogistics.Repo]

# Configures the endpoint
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE") || "fallback_secret_key",  # Retrieve from environment variable
  render_errors: [view: TrainFoodLogisticsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TrainFoodLogistics.PubSub,
  live_view: [signing_salt: System.get_env("SIGNING_SALT") || "fallback_signing_salt"] # Retrieve from environment variable

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  level: case Mix.env() do
    :prod -> :info
    :dev -> :debug
    :test -> :warn
  end

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure the database
config :train_food_logistics, TrainFoodLogistics.Repo,
  username: System.get_env("DB_USERNAME") || "postgres",  # Fetch from environment
  password: System.get_env("DB_PASSWORD") || "postgres",  # Fetch from environment
  database: "train_food_logistics_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Redis configuration (if caching is used)
config :redix,
  host: "localhost",
  port: 6379,
  db: 0,                    # Use default Redis database (can be changed)
  password: System.get_env("REDIS_PASSWORD") # Secure Redis access with password

# Email configuration
config :train_food_logistics, TrainFoodLogistics.Mailer,
  adapter: Swoosh.Adapters.Local

# SMS Service configuration
config :train_food_logistics, :sms_service,
  service: "twilio",
  account_sid: System.get_env("TWILIO_ACCOUNT_SID"),
  auth_token: System.get_env("TWILIO_AUTH_TOKEN")

# Payment Gateway Configuration
config :train_food_logistics, :payment_gateway,
  provider: "stripe",
  public_key: System.get_env("STRIPE_PUBLIC_KEY"),
  secret_key: System.get_env("STRIPE_SECRET_KEY")

# Analytics Service Configuration
config :train_food_logistics, :analytics_service,
  provider: "google_analytics",
  tracking_id: System.get_env("GA_TRACKING_ID")

# Push Notifications Configuration
config :train_food_logistics, :push_notifications,
  provider: "firebase",
  api_key: System.get_env("FIREBASE_API_KEY"),
  project_id: System.get_env("FIREBASE_PROJECT_ID")

# File Storage Configuration
config :train_food_logistics, :file_storage,
  provider: "aws_s3",
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  region: System.get_env("AWS_REGION"),
  bucket: System.get_env("AWS_BUCKET")

# Background Job Processing Configuration
config :train_food_logistics, :background_jobs,
  provider: "oban",
  repo: TrainFoodLogistics.Repo,
  queues: [default: 10, mailers: 20, analytics: 5],
  plugins: [Oban.Plugins.Pruner]

# Import environment-specific config (dev, test, prod)
import_config "#{Mix.env()}.exs"
