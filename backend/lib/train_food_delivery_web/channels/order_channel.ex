defmodule TrainFoodDeliveryWeb.OrderChannel do
  use Phoenix.Channel

  def join("orders:lobby", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("new_order", %{"order" => order}, socket) do
    # Broadcast order updates to connected clients
    broadcast!(socket, "order_update", %{order: order})
    {:noreply, socket}
  end
end
