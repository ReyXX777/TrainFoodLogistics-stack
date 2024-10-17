defmodule TrainFoodDelivery.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :item_name, :string
    field :quantity, :integer
    field :status, :string, default: "pending"
    field :eta, :integer, virtual: true  # ETA will be calculated in real-time

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:item_name, :quantity, :status])
    |> validate_required([:item_name, :quantity])
  end
end
