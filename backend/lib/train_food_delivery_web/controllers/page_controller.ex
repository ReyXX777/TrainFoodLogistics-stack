defmodule TrainFoodDeliveryWeb.PageController do
  use TrainFoodDeliveryWeb, :controller

  # Render the homepage
  def index(conn, _params) do
    render(conn, "index.html")
  end

  # Render the about page
  def about(conn, _params) do
    render(conn, "about.html")
  end

  # Render the contact page
  def contact(conn, _params) do
    render(conn, "contact.html")
  end

  # Render the FAQ page
  def faq(conn, _params) do
    render(conn, "faq.html")
  end

  # Render the terms and conditions page
  def terms_and_conditions(conn, _params) do
    render(conn, "terms_and_conditions.html")
  end

  # Handle a 404 error for pages not found
  def not_found(conn, _params) do
    conn
    |> put_flash(:error, "Page not found")
    |> render("404.html")
  end

  # Handle a 500 error for internal server errors
  def internal_server_error(conn, _params) do
    conn
    |> put_flash(:error, "Internal server error")
    |> render("500.html")
  end

  # Render the menu page
  def menu(conn, _params) do
    # Fetch menu items from the database or a service
    menu_items = [
      %{name: "Pizza Margherita", price: 12.99, description: "Classic tomato and mozzarella pizza"},
      %{name: "Burger", price: 9.99, description: "Juicy beef burger with all the fixings"},
      %{name: "Sushi Platter", price: 24.99, description: "Assortment of fresh sushi rolls"},
      # ... more menu items
    ]
    render(conn, "menu.html", menu_items: menu_items)
  end

  # Render the promotions page
  def promotions(conn, _params) do
    # Fetch current promotions from the database or a service
    promotions = [
      %{title: "Pizza Deal", description: "Buy one pizza, get one half price"},
      %{title: "Burger Combo", description: "Burger, fries, and a drink for $15"},
      # ... more promotions
    ]
    render(conn, "promotions.html", promotions: promotions)
  end
end
