class SalesOrderItem < ApplicationRecord
  belongs_to :sales_order
  belongs_to :product

  def total_price
    quantity * price
  end

  after_save :update_sales_order_total
  after_destroy :update_sales_order_total

  private

  def update_sales_order_total
    sales_order.calculate_total_price
  end
end
