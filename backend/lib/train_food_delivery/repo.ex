defmodule TrainFoodDelivery.Repo do
  use Ecto.Repo,
    otp_app: :train_food_logistics,  # The application name, used for configuration
    adapter: Ecto.Adapters.Postgres   # Specifying the database adapter (Postgres in this case)

  # Optional: Configure the repository's logging behavior (can be adjusted per environment)
  def init(_type, config) do
    # Dynamically adjust configurations (e.g., from environment variables or other sources)
    {:ok, Keyword.put(config, :log, :debug)}
  end

  # Custom function to log query execution times
  def log_query_time(query, params, time) do
    IO.puts("Executed query: #{inspect(query)}")
    IO.puts("With params: #{inspect(params)}")
    IO.puts("Execution time: #{time}ms")
  end

  # Custom function for database health checks
  def health_check do
    case __MODULE__.query("SELECT 1") do
      {:ok, _result} -> {:ok, "Database connection is healthy"}
      {:error, _reason} -> {:error, "Database connection failed"}
    end
  end

  # Function to retrieve connection pool size
  def connection_pool_size do
    Application.get_env(:train_food_logistics, __MODULE__)[:pool_size] || 10
  end
end
