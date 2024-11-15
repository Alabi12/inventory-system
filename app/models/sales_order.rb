class SalesOrder < ApplicationRecord
  belongs_to :customer
  has_many :sales_order_items
  has_many :products, through: :sales_order_items

  validates :order_date, :status, presence: true

  enum status: { pending: 0, shipped: 1, delivered: 2, cancelled: 3 }
end
