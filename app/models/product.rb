class Product < ApplicationRecord
  belongs_to :supplier
  has_many :stock_movements, dependent: :destroy
  has_many :purchase_order_items
  # has_many :sales_order_items
  validates :product_code, presence: true, uniqueness: true
  has_many :purchase_orders, through: :purchase_order_items
  has_many :sales_orders, through: :sales_order_items

  validates :name, :product_code, :category, :quantity, :price, presence: true
end
