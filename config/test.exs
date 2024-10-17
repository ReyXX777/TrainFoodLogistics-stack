use Mix.Config

# Configure your database for testing
config :train_food_delivery, TrainFoodDelivery.Repo,
  username: "postgres",
  password: "postgres",
  database: "train_food_delivery_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required, you can enable the server option below.
config :train_food_delivery, TrainFoodDeliveryWeb.Endpoint,
  http: [port: 4002],
  server: false

# Set test log level to warn to reduce log noise during tests
config :logger, level: :warn

# Disable Redis for caching in test
config :redix,
  host: "localhost",
  port: 6379,
  enabled: false

# Mock SMS service for testing
config :train_food_delivery, :sms_service,
  service: "mock_sms",
  api_key: "test_key"

# Use a test adapter for email delivery (e.g., Local or Test)
config :train_food_delivery, TrainFoodDelivery.Mailer,
  adapter: Swoosh.Adapters.Test
