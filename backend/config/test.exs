use Mix.Config

# Configure the database for the test environment
# Uses Ecto's SQL sandbox for isolated database tests
config :train_food_delivery, TrainFoodDelivery.Repo,
  username: "postgres",                # Database username
  password: "postgres",                # Database password
  database: "train_food_delivery_test", # Test database name
  hostname: "localhost",               # Database host
  pool: Ecto.Adapters.SQL.Sandbox      # Pooling for test isolation

# Web endpoint configuration
# Server is disabled during testing as tests typically don't need a running server
config :train_food_delivery, TrainFoodDeliveryWeb.Endpoint,
  http: [port: 4002],  # HTTP port for the web server (if enabled)
  server: false        # Disable the server during tests

# Logger configuration
# Sets log level to :warn to minimize log output during tests
config :logger, level: :warn

# Redis configuration for caching
# Disables Redis in the test environment to avoid external dependencies
config :redix,
  host: "localhost",  # Redis host
  port: 6379,         # Redis port
  enabled: false      # Disable Redis in tests

# Mock SMS service configuration
# Uses a mock service for testing SMS delivery to avoid real SMS charges
config :train_food_delivery, :sms_service,
  service: "mock_sms", # Mock SMS service identifier
  api_key: "test_key"  # Test API key for the mock service

# Email delivery configuration
# Uses a test adapter (Swoosh.Adapters.Test) to avoid sending real emails
config :train_food_delivery, TrainFoodDelivery.Mailer,
  adapter: Swoosh.Adapters.Test # Test adapter for email delivery
