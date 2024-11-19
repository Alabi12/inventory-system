class Customer < ApplicationRecord
  has_many :purchase_orders
  has_many :products, through: :purchase_orders
  validates :name, :email, :phone, presence: true
end
