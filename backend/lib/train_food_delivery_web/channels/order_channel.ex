defmodule TrainFoodDeliveryWeb.OrderChannel do
  use Phoenix.Channel

  # Handle joining the 'orders:lobby' topic
  def join("orders:lobby", _payload, socket) do
    # You can add authentication logic here if needed.
    {:ok, socket}
  end

  # Handle receiving a new order event
  def handle_in("new_order", %{"order" => order}, socket) do
    # Perform any necessary processing for the order here (e.g., storing the order in the database)
    
    # Broadcast the order update to all connected clients in the 'orders:lobby' topic
    broadcast!(socket, "order_update", %{order: order})
    
    # Return the socket without replying to the sender
    {:noreply, socket}
  end

  # Optionally handle a message for a specific client (e.g., acknowledgement or response)
  def handle_in("acknowledge_order", %{"order_id" => order_id}, socket) do
    # You could update the order status here or acknowledge the message to the sender
    # You could also fetch order details from a database, update status, etc.
    IO.puts("Order acknowledged: #{order_id}")
    
    # Respond back to the client
    push(socket, "order_acknowledged", %{order_id: order_id, status: "acknowledged"})
    
    {:noreply, socket}
  end

  # Handle when a client leaves the channel (optional)
  def terminate(_reason, _socket) do
    # You can add cleanup logic here, like logging or removing user from some tracking list.
    :ok
  end
end
