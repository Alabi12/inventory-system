class Customer < ApplicationRecord
  has_many :sales_orders

  validates :name, :email, :phone, presence: true
end
