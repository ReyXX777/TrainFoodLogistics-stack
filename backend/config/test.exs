use Mix.Config

# Configure the database for the test environment
# Uses Ecto's SQL sandbox for isolated database tests
config :train_food_delivery, TrainFoodDelivery.Repo,
  username: "postgres",
  password: "postgres",
  database: "train_food_delivery_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# Web endpoint configuration
# Server is disabled during testing as tests typically don't need a running server
config :train_food_delivery, TrainFoodDeliveryWeb.Endpoint,
  http: [port: 4002],
  server: false

# Logger configuration
# Sets log level to :warn to minimize log output during tests
config :logger, level: :warn

# Redis configuration for caching
# Disables Redis in the test environment to avoid external dependencies
config :redix,
  host: "localhost",
  port: 6379,
  enabled: false

# Mock SMS service configuration
# Uses a mock service for testing SMS delivery to avoid real SMS charges
config :train_food_delivery, :sms_service,
  service: "mock_sms",
  api_key: "test_key"

# Email delivery configuration
# Uses a test adapter (Swoosh.Adapters.Test) to avoid sending real emails
config :train_food_delivery, TrainFoodDelivery.Mailer,
  adapter: Swoosh.Adapters.Test

# External service APIs configuration (mock or test services)
# Ensure no external API calls are made in tests
config :train_food_delivery, :external_services,
  use_mock: true,
  mock_data: %{
    sms: %{
      success_response: %{"status" => "sent"},
      failure_response: %{"status" => "failed"}
    },
    email: %{
      success_response: %{"status" => "delivered"},
      failure_response: %{"status" => "undelivered"}
    }
  }

# Payment gateway configuration for tests
# Uses a mock payment gateway to simulate transactions
config :train_food_delivery, :payment_gateway,
  provider: "mock_gateway",
  success_response: %{"status" => "success", "transaction_id" => "test_txn_12345"},
  failure_response: %{"status" => "failure", "error_code" => "insufficient_funds"}

# Analytics service configuration for tests
# Mocking analytics service to avoid real data collection
config :train_food_delivery, :analytics_service,
  provider: "mock_analytics",
  mock_events: [
    %{"event" => "user_signup", "status" => "recorded"},
    %{"event" => "order_placed", "status" => "recorded"}
  ]

# Push notifications configuration for tests
# Disables push notifications during testing
config :train_food_delivery, :push_notifications,
  enabled: false,
  mock_response: %{"status" => "disabled"}

# Feature Flags configuration for tests
# Define feature flags and their default values for testing
config :train_food_delivery, :feature_flags,
  new_menu_enabled: false, # Example feature flag: New menu
  promotional_offers_enabled: true # Example feature flag: Promotional offers

# Search Configuration for Tests
# Mocking search service to avoid dependency on external search engine
config :train_food_delivery, :search_service,
  provider: "mock_search",
  mock_results: %{
    "pizza" => [%{name: "Pizza Margherita", price: 12.99}],
    "burger" => [%{name: "Classic Burger", price: 9.99}]
  }
