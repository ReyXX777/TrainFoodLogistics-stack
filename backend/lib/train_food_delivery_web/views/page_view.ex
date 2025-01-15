defmodule TrainFoodDeliveryWeb.PageView do
  use TrainFoodDeliveryWeb, :view

  # If you need to define custom helpers for the page templates, you can add them here.
  # For example, a helper to format text or date:

  def format_date(date) do
    # Format the date in a readable format, e.g., "January 3, 2025"
    Timex.Format.Formatter.format!(date, "{Mfull} {D}, {YYYY}")
  end

  # Helper to check if a user is logged in
  def logged_in?(conn) do
    # Check if the user is authenticated (assuming session has a user_id)
    conn.assigns[:current_user] != nil
  end

  # Helper to display a user's name
  def user_name(conn) do
    # Fetch the user's name from the session or database if logged in
    if logged_in?(conn) do
      conn.assigns[:current_user].name
    else
      "Guest"
    end
  end

  # Helper to format currency values
  def format_currency(amount) do
    # Format the amount as a currency string, e.g., "$10.00"
    "$" <> Float.round(amount, 2) |> to_string()
  end

  # Helper to generate a link to a user's profile
  def user_profile_link(conn) do
    if logged_in?(conn) do
      Routes.user_path(conn, :show, conn.assigns[:current_user].id)
    else
      "#"
    end
  end
end
