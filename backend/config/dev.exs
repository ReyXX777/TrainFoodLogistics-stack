# config/dev.exs
use Mix.Config

# Configure the database for the development environment
config :train_food_logistics, TrainFoodLogistics.Repo,
  username: System.get_env("DB_USERNAME") || "postgres",    # Fetch from environment variable or fallback
  password: System.get_env("DB_PASSWORD") || "postgres",    # Fetch from environment variable or fallback
  database: "train_food_logistics_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Configure the endpoint for development
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js", 
      "--mode", 
      "development",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Configures live reload for static and templates
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$", 
      ~r"priv/gettext/.*(po)$",                         
      ~r"lib/train_food_logistics_web/(live|views)/.*(ex)$", 
      ~r"lib/train_food_logistics_web/templates/.*(eex)$"
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
  port: 6379,
  password: System.get_env("REDIS_PASSWORD") # Ensure Redis authentication for production

# Email delivery configuration for development
config :train_food_logistics, TrainFoodLogistics.Mailer,
  adapter: Swoosh.Adapters.Local # Local adapter to view emails in the browser

# SMS service configuration for development
config :train_food_logistics, :sms_service,
  service: "twilio",
  account_sid: System.get_env("TWILIO_ACCOUNT_SID") || "your_dev_sid",  # Retrieve from environment or use fallback
  auth_token: System.get_env("TWILIO_AUTH_TOKEN") || "your_dev_token"   # Retrieve from environment or use fallback

# Payment gateway configuration
config :train_food_logistics, :payment_gateway,
  provider: "stripe",
  public_key: System.get_env("STRIPE_PUBLIC_KEY") || "dev_public_key",
  secret_key: System.get_env("STRIPE_SECRET_KEY") || "dev_secret_key"

# Analytics service configuration
config :train_food_logistics, :analytics_service,
  provider: "mixpanel",
  api_key: System.get_env("MIXPANEL_API_KEY") || "dev_mixpanel_api_key"

# Push notifications configuration
config :train_food_logistics, :push_notifications,
  provider: "firebase",
  api_key: System.get_env("FIREBASE_API_KEY") || "dev_firebase_api_key",
  project_id: System.get_env("FIREBASE_PROJECT_ID") || "dev_firebase_project_id"
