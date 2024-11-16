class Supplier < ApplicationRecord
  has_many :purchase_orders
  has_many :products, dependent: :destroy
  has_many :sales_orders

  validates :name, :email, :phone, presence: true
end
