defmodule TrainFoodDelivery.Repo do
  use Ecto.Repo,
    otp_app: :train_food_logistics,  # The application name, used for configuration
    adapter: Ecto.Adapters.Postgres   # Specifying the database adapter (Postgres in this case)

  # Optional: Configure the repository's logging behavior (can be adjusted per environment)
  def init(_type, config) do
    # You can dynamically adjust configurations here (e.g., from environment variables or other sources)
    {:ok, config}
  end
end
