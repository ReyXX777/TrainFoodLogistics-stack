defmodule TrainFoodDeliveryWeb.OrderController do
  use TrainFoodDeliveryWeb, :controller
  alias TrainFoodDelivery.Orders
  alias TrainFoodDelivery.Orders.Order

  # List all orders
  def index(conn, _params) do
    orders = Orders.list_orders() # Fetch all orders from the database
    render(conn, "index.html", orders: orders)
  end

  # Show a specific order by ID
  def show(conn, %{"id" => id}) do
    case Orders.get_order(id) do
      nil ->
        # If the order is not found, return a 404 error
        conn
        |> put_flash(:error, "Order not found.")
        |> redirect(to: Routes.order_path(conn, :index))

      order ->
        # If the order is found, render the order details
        render(conn, "show.html", order: order)
    end
  end

  # Create a new order
  def create(conn, %{"order" => order_params}) do
    case Orders.create_order(order_params) do
      {:ok, order} ->
        # If the order is created successfully, redirect to the show page
        conn
        |> put_flash(:info, "Order created successfully.")
        |> redirect(to: Routes.order_path(conn, :show, order))

      {:error, %Ecto.Changeset{} = changeset} ->
        # If there is an error in the changeset, re-render the form with errors
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
        # If the order is not found, return a 404 error
        conn
        |> put_flash(:error, "Order not found.")
        |> redirect(to: Routes.order_path(conn, :index))

      order ->
        # If the order is found, render the edit form with the current order
        changeset = Orders.change_order(order)
        render(conn, "edit.html", order: order, changeset: changeset)
    end
  end

  # Update an existing order
  def update(conn, %{"id" => id, "order" => order_params}) do
    case Orders.get_order(id) do
      nil ->
        # If the order is not found, return a 404 error
        conn
        |> put_flash(:error, "Order not found.")
        |> redirect(to: Routes.order_path(conn, :index))

      order ->
        case Orders.update_order(order, order_params) do
          {:ok, order} ->
            # If the order is updated successfully, redirect to the show page
            conn
            |> put_flash(:info, "Order updated successfully.")
            |> redirect(to: Routes.order_path(conn, :show, order))

          {:error, %Ecto.Changeset{} = changeset} ->
            # If there is an error in the changeset, re-render the form with errors
            render(conn, "edit.html", order: order, changeset: changeset)
        end
    end
  end

  # Delete an order
  def delete(conn, %{"id" => id}) do
    case Orders.get_order(id) do
      nil ->
        # If the order is not found, return a 404 error
        conn
        |> put_flash(:error, "Order not found.")
        |> redirect(to: Routes.order_path(conn, :index))

      order ->
        case Orders.delete_order(order) do
          {:ok, _order} ->
            # If the order is deleted successfully, redirect to the index page
            conn
            |> put_flash(:info, "Order deleted successfully.")
            |> redirect(to: Routes.order_path(conn, :index))

          {:error, _changeset} ->
            # Handle any error during deletion (if any)
            conn
            |> put_flash(:error, "Failed to delete the order.")
            |> redirect(to: Routes.order_path(conn, :index))
        end
    end
  end
end
