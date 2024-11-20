class Supplier < ApplicationRecord
  has_many :sales_orders
  has_many :purchase_orders
  has_many :products, dependent: :destroy

  validates :name, :email, :phone, presence: true

  has_many :purchase_order_items, through: :purchase_orders
end
