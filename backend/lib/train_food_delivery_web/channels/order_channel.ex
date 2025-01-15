defmodule TrainFoodDeliveryWeb.OrderChannel do
  use Phoenix.Channel

  # Handle joining the 'orders:lobby' topic
  def join("orders:lobby", _payload, socket) do
    # Add optional authentication or logging logic here
    IO.puts("Client joined the orders:lobby")
    {:ok, socket}
  end

  # Handle receiving a new order event
  def handle_in("new_order", %{"order" => order}, socket) do
    # Perform order validation or additional processing if needed
    IO.puts("New order received: #{inspect(order)}")

    # Broadcast the order update to all connected clients in the 'orders:lobby' topic
    broadcast!(socket, "order_update", %{order: order})

    {:noreply, socket}
  end

  # Handle an event to acknowledge an order
  def handle_in("acknowledge_order", %{"order_id" => order_id}, socket) do
    IO.puts("Order acknowledged: #{order_id}")

    # Respond to the client with an acknowledgment
    push(socket, "order_acknowledged", %{order_id: order_id, status: "acknowledged"})

    {:noreply, socket}
  end

  # Handle updating the order status
  def handle_in("update_order_status", %{"order_id" => order_id, "status" => status}, socket) do
    # You can add logic here to update the order status in the database
    IO.puts("Order #{order_id} status updated to: #{status}")

    # Broadcast the status update to all connected clients
    broadcast!(socket, "order_status_update", %{order_id: order_id, status: status})

    {:noreply, socket}
  end

  # Handle retrieving order details
  def handle_in("get_order_details", %{"order_id" => order_id}, socket) do
    # Mock order details (in a real application, fetch from the database)
    order_details = %{
      order_id: order_id,
      item: "Pizza",
      quantity: 2,
      status: "pending",
      estimated_time: 30
    }

    # Push the order details back to the requesting client
    push(socket, "order_details", %{order: order_details})

    {:noreply, socket}
  end

  # Handle when a client leaves the channel
  def terminate(_reason, socket) do
    IO.puts("Client left the orders:lobby")
    :ok
  end
end
