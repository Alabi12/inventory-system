class InventoryItem < ApplicationRecord
  belongs_to :product
  belongs_to :supplier

  def opening_inventory(start_date = Time.current.beginning_of_month)
    return 0 unless product

    product.stock_movements.where("created_at < ?", start_date).sum(:quantity)
  end

  def calculate_closing_inventory(sold_quantity)
    quantity - sold_quantity
  end
end
