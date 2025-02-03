defmodule TrainFoodDeliveryWeb.OrderChannel do
  use Phoenix.Channel

  # Handle joining the 'orders:lobby' topic
  def join("orders:lobby", _payload, socket) do
    # Add optional authentication or logging logic here
    IO.puts("Client joined the orders:lobby")
    {:ok, assign(socket, user_id: socket.id)} # Assign a user ID to the socket
  end

  # Handle receiving a new order event
  def handle_in("new_order", %{"order" => order}, socket) do
    # Perform order validation or additional processing if needed
    IO.puts("New order received: #{inspect(order)}")

    # Add user ID to the order data
    order_with_user = Map.merge(order, %{user_id: socket.assigns.user_id})


    # Broadcast the order update to all connected clients in the 'orders:lobby' topic
    broadcast!(socket, "order_update", %{order: order_with_user})

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

    # Handle chat messages
  def handle_in("chat_message", %{"message" => message}, socket) do
    # Broadcast the message to all connected clients
    broadcast!(socket, "new_chat_message", %{
      user_id: socket.assigns.user_id,  # Include user ID
      message: message
    })
    {:noreply, socket}
  end


  # Handle when a client leaves the channel
  def terminate(_reason, socket) do
    IO.puts("Client #{socket.assigns.user_id} left the orders:lobby") # Log user ID on disconnect
    :ok
  end
end
