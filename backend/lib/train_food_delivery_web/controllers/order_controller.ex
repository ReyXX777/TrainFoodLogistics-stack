defmodule TrainFoodDeliveryWeb.OrderController do
  use TrainFoodDeliveryWeb, :controller
  alias TrainFoodDelivery.Orders
  alias TrainFoodDelivery.Orders.Order
  alias TrainFoodDelivery.Accounts.User # Alias User context

  # List all orders (with pagination)
  def index(conn, params) do
    page = Map.get(params, "page", "1") |> String.to_integer()
    per_page = Map.get(params, "per_page", "10") |> String.to_integer()

    orders = Orders.list_orders(page, per_page)
    total_orders = Orders.count_orders()

    conn
    |> assign(:orders, orders)
    |> assign(:total_orders, total_orders)
    |> assign(:page, page)
    |> assign(:per_page, per_page)
    |> render("index.html")
  end

  # ... (Other actions: show, create, new, edit, update, delete remain similar)

  # Search orders by status and/or user
  def search(conn, params) do
    status = params["status"]
    user_id = params["user_id"]

    orders = Orders.search_orders(status, user_id)

    render(conn, "index.html", orders: orders)
  end

  # Assign order to a driver
  def assign_driver(conn, %{"id" => order_id, "driver_id" => driver_id}) do
    case Orders.assign_driver(order_id, driver_id) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order assigned to driver successfully.")
        |> redirect(to: Routes.order_path(conn, :show, order))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Failed to assign driver to order.")
        |> redirect(to: Routes.order_path(conn, :show, order_id))
    end
  end


  # ... (bulk_delete and export_to_csv remain similar)
end
