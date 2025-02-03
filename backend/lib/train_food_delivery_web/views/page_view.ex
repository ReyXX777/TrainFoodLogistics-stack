defmodule TrainFoodDeliveryWeb.PageView do
  use TrainFoodDeliveryWeb, :view

  # Format date
  def format_date(date) do
    Timex.Format.Formatter.format!(date, "{Mfull} {D}, {YYYY}")
  end

  # Check if user is logged in
  def logged_in?(conn) do
    conn.assigns[:current_user] != nil
  end

  # Display user's name
  def user_name(conn) do
    if logged_in?(conn) do
      conn.assigns[:current_user].name
    else
      "Guest"
    end
  end

  # Format currency
  def format_currency(amount) do
    "$ " <> Float.round(amount, 2) |> to_string()
  end

  # Generate user profile link
  def user_profile_link(conn) do
    if logged_in?(conn) do
      Routes.user_path(conn, :show, conn.assigns[:current_user].id)
    else
      "#"
    end
  end

  # Helper to generate a link to a restaurant's menu
  def restaurant_menu_link(conn, restaurant_id) do
    Routes.restaurant_path(conn, :menu, restaurant_id) # Assuming you have a route for restaurant menus
  end

  # Helper to display the order status with color coding
  def order_status_tag(status) do
    case status do
      "pending" -> "<span class='status-tag pending'>#{status}</span>"
      "processed" -> "<span class='status-tag processed'>#{status}</span>"
      "shipped" -> "<span class='status-tag shipped'>#{status}</span>"
      "delivered" -> "<span class='status-tag delivered'>#{status}</span>"
      "cancelled" -> "<span class='status-tag cancelled'>#{status}</span>"
      _ -> status # Default display without tag
    end |> safe_to_string() # Mark as safe HTML
  end
end
