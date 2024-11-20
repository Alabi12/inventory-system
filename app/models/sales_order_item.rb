class SalesOrderItem < ApplicationRecord
  belongs_to :sales_order
  belongs_to :product

  def total_price
    quantity * price
  end
end
