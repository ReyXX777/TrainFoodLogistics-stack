# config/prod.exs
use Mix.Config

# Configure the database for the production environment
config :train_food_logistics, TrainFoodLogistics.Repo,
  username: System.get_env("DB_USERNAME") || "postgres",        # Use environment variables for credentials
  password: System.get_env("DB_PASSWORD") || "postgres",        # Default value for local fallback
  database: System.get_env("DB_NAME") || "train_food_logistics_prod", # Production database name
  hostname: System.get_env("DB_HOST") || "localhost",           # Database host
  pool_size: String.to_integer(System.get_env("DB_POOL_SIZE") || "15"), # Configurable pool size
  ssl: true                                                     # Enable SSL for secure connections

# Configure the endpoint for production
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),  # Port configured via environment variable
    transport_options: [socket_opts: [:inet6]]                  # Enable IPv6
  ],
  url: [
    scheme: "https",                                            # Use HTTPS in production
    host: System.get_env("HOST") || "example.com",              # Public-facing hostname
    port: 443                                                   # HTTPS port
  ],
  cache_static_manifest: "priv/static/cache_manifest.json",      # Cache static files
  secret_key_base: System.get_env("SECRET_KEY_BASE"),            # Secret key for session encryption

# Force SSL for secure communication
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  force_ssl: [rewrite_on: [:x_forwarded_proto]]                 # Ensure HTTP to HTTPS redirection

# Logger configuration for production
config :logger, :console,
  format: "$time $metadata[$level] $message\n",                  # Log format
  metadata: [:request_id],                                       # Include request ID in logs

# Set lower stacktrace depth to improve performance in production
config :phoenix, :stacktrace_depth, 10

# Redis configuration for caching in production
config :redix,
  host: System.get_env("REDIS_HOST") || "localhost",             # Redis host
  port: String.to_integer(System.get_env("REDIS_PORT") || "6379"), # Redis port
  password: System.get_env("REDIS_PASSWORD")                    # Redis password for production (ensure security)

# Email delivery configuration for production
config :train_food_logistics, TrainFoodLogistics.Mailer,
  adapter: Swoosh.Adapters.SMTP,                                 # Use SMTP adapter for production
  relay: System.get_env("SMTP_RELAY"),                           # SMTP server
  username: System.get_env("SMTP_USERNAME"),                     # SMTP username
  password: System.get_env("SMTP_PASSWORD"),                     # SMTP password
  ssl: true,                                                     # Enable SSL for email
  tls: :if_available,                                            # Enable TLS if supported
  port: 587                                                      # SMTP port

# SMS service configuration for production
config :train_food_logistics, :sms_service,
  service: "twilio",                                             # SMS service provider
  account_sid: System.get_env("TWILIO_ACCOUNT_SID"),             # Twilio account SID
  auth_token: System.get_env("TWILIO_AUTH_TOKEN")                # Twilio auth token

# Payment gateway configuration
config :train_food_logistics, :payment_gateway,
  provider: "stripe",
  public_key: System.get_env("STRIPE_PUBLIC_KEY"),
  secret_key: System.get_env("STRIPE_SECRET_KEY")

# Analytics service configuration
config :train_food_logistics, :analytics_service,
  provider: "datadog",
  api_key: System.get_env("DATADOG_API_KEY")

# Push notifications configuration
config :train_food_logistics, :push_notifications,
  provider: "firebase",
  api_key: System.get_env("FIREBASE_API_KEY"),
  project_id: System.get_env("FIREBASE_PROJECT_ID")

# Runtime configuration for releases
config :train_food_logistics, TrainFoodLogisticsWeb.Endpoint,
  server: true                                                   # Ensure the server is started in production
