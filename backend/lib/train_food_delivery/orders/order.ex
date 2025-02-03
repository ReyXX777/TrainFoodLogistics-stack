defmodule TrainFoodDelivery.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @valid_statuses ["pending", "processed", "shipped", "delivered", "cancelled"]

  schema "orders" do
    field :item_name, :string
    field :quantity, :integer
    field :status, :string, default: "pending"
    field :total_price, :float
    field :delivery_address, :string
    field :eta, :integer, virtual: true
    field :user_id, :integer # New field for user ID (foreign key)
    field :restaurant_id, :integer # New field for restaurant ID (foreign key)
    field :order_date, :date, default: Date.utc_today() # New field for the order date
    field :payment_method, :string # New field to store the payment method

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:item_name, :quantity, :status, :total_price, :delivery_address, :user_id, :restaurant_id, :order_date, :payment_method])
    |> validate_required([:item_name, :quantity, :delivery_address, :user_id, :restaurant_id, :payment_method]) # Added user_id and restaurant_id to required fields
    |> validate_inclusion(:status, @valid_statuses)
    |> validate_quantity()
    |> validate_number(:total_price, greater_than_or_equal_to: 0, message: "must be a non-negative value")
    |> validate_length(:delivery_address, min: 10, message: "must be at least 10 characters long")
    |> validate_inclusion(:payment_method, ["card", "cash", "other"], message: "Invalid payment method") # Validate payment method
  end

  # Validation for quantity to ensure it is a positive integer
  defp validate_quantity(changeset) do
    validate_number(changeset, :quantity, greater_than: 0, message: "must be greater than zero")
  end

  # Optionally, a function to calculate ETA based on order details (virtual field)
  def calculate_eta(order) do
    # Example logic: ETA is calculated based on the item type and quantity
    base_eta = case order.item_name do
      "Pizza" -> 30 # 30 minutes for pizza
      "Burger" -> 20 # 20 minutes for burgers
      "Sushi" -> 40 # 40 minutes for sushi
      _ -> 25 # Default for other items
    end

    eta = base_eta + (order.quantity * 2) # Add 2 minutes per item as a simple example
    eta
  end

  # Function to calculate total price
  def calculate_total_price(order, item_price) do
    order.quantity * item_price
  end
end
