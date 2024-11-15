class SalesOrderItem < ApplicationRecord
  belongs_to :sales_order
  belongs_to :product

  validates :quantity, presence: true
end
