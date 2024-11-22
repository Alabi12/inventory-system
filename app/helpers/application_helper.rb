module ApplicationHelper
  def calculate_total(quantity, price)
    (quantity || 0) * (price || 0)
  end
end

