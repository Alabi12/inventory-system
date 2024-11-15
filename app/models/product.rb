class Product < ApplicationRecord
  has_many :purchase_order_items
  has_many :sales_order_items
  has_many :purchase_orders, through: :purchase_order_items
  has_many :sales_orders, through: :sales_order_items

  validates :name, :sku, :price, presence: true
end
