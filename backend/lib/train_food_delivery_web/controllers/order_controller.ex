defmodule TrainFoodDeliveryWeb.OrderController do
  use TrainFoodDeliveryWeb, :controller
  alias TrainFoodDelivery.Orders
  alias TrainFoodDelivery.Orders.Order

  # List all orders
  def index(conn, _params) do
    orders = Orders.list_orders()
    render(conn, "index.html", orders: orders)
  end

  # Show a specific order by ID
  def show(conn, %{"id" => id}) do
    case Orders.get_order(id) do
      nil ->
        conn
        |> put_flash(:error, "Order not found.")
        |> redirect(to: Routes.order_path(conn, :index))

      order ->
        render(conn, "show.html", order: order)
    end
  end

  # Create a new order
  def create(conn, %{"order" => order_params}) do
    case Orders.create_order(order_params) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order created successfully.")
        |> redirect(to: Routes.order_path(conn, :show, order))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # Render a form for creating a new order
  def new(conn, _params) do
    changeset = Orders.change_order(%Order{})
    render(conn, "new.html", changeset: changeset)
  end

  # Edit an existing order
  def edit(conn, %{"id" => id}) do
    case Orders.get_order(id) do
      nil ->
        conn
        |> put_flash(:error, "Order not found.")
        |> redirect(to: Routes.order_path(conn, :index))

      order ->
        changeset = Orders.change_order(order)
        render(conn, "edit.html", order: order, changeset: changeset)
    end
  end

  # Update an existing order
  def update(conn, %{"id" => id, "order" => order_params}) do
    case Orders.get_order(id) do
      nil ->
        conn
        |> put_flash(:error, "Order not found.")
        |> redirect(to: Routes.order_path(conn, :index))

      order ->
        case Orders.update_order(order, order_params) do
          {:ok, order} ->
            conn
            |> put_flash(:info, "Order updated successfully.")
            |> redirect(to: Routes.order_path(conn, :show, order))

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "edit.html", order: order, changeset: changeset)
        end
    end
  end

  # Delete an order
  def delete(conn, %{"id" => id}) do
    case Orders.get_order(id) do
      nil ->
        conn
        |> put_flash(:error, "Order not found.")
        |> redirect(to: Routes.order_path(conn, :index))

      order ->
        case Orders.delete_order(order) do
          {:ok, _order} ->
            conn
            |> put_flash(:info, "Order deleted successfully.")
            |> redirect(to: Routes.order_path(conn, :index))

          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Failed to delete the order.")
            |> redirect(to: Routes.order_path(conn, :index))
        end
    end
  end

  # Search orders by status
  def search_by_status(conn, %{"status" => status}) do
    orders = Orders.list_orders_by_status(status)
    render(conn, "index.html", orders: orders)
  end

  # Bulk delete orders
  def bulk_delete(conn, %{"ids" => ids}) do
    case Orders.bulk_delete_orders(ids) do
      {:ok, _count} ->
        conn
        |> put_flash(:info, "Selected orders deleted successfully.")
        |> redirect(to: Routes.order_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Failed to delete selected orders.")
        |> redirect(to: Routes.order_path(conn, :index))
    end
  end

  # Export orders to CSV
  def export_to_csv(conn, _params) do
    csv_data = Orders.export_orders_to_csv()
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"orders.csv\"")
    |> send_resp(200, csv_data)
  end
end
