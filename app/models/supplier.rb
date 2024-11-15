class Supplier < ApplicationRecord
  has_many :purchase_orders

  validates :name, :email, :phone, presence: true
end
