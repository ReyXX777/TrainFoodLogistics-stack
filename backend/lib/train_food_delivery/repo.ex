defmodule TrainFoodDelivery.Repo do
  use Ecto.Repo,
    otp_app: :train_food_delivery,
    adapter: Ecto.Adapters.Postgres

  # Optional: Configure the repository's logging behavior
  def init(_type, config) do
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
    Application.get_env(:train_food_delivery, __MODULE__)[:pool_size] || 10
  end

  # Function to run migrations
  def run_migrations do
    Ecto.Migrator.run(:up, Repo, Repo.migrations_path())
  end

  # Function to seed the database with initial data
  def seed_database do
    # Example: Insert initial users
    case insert_user(%{email: "test@example.com", username: "testuser", password: "password"}) do
      {:ok, _} -> IO.puts("User seeded successfully")
      {:error, reason} -> IO.puts("Error seeding user: #{inspect(reason)}")
    end

    # Add more seeding logic as needed
  end

  defp insert_user(attrs) do
      %TrainFoodDelivery.Accounts.User{}
      |> TrainFoodDelivery.Accounts.User.changeset(attrs)
      |> Repo.insert()
  end

end
