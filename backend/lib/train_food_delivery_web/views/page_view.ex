defmodule TrainFoodDeliveryWeb.PageView do
  use TrainFoodDeliveryWeb, :view

  # If you need to define custom helpers for the page templates, you can add them here.
  # For example, a helper to format text or date:
  
  def format_date(date) do
    # Format the date in a readable format, e.g., "January 3, 2025"
    Timex.Format.Formatter.format!(date, "{Mfull} {D}, {YYYY}")
  end
end
