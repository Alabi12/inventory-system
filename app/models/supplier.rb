class Supplier < ApplicationRecord
  has_many :purchase_orders
  has_many :products

  validates :name, :email, :phone, presence: true
end
