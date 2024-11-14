class Supplier < ApplicationRecord
  has_many :products, dependent: :nullify 
  has_many :orders, through: :products # This allows a supplier to access orders through their products
  validates :name, :contact_info, presence: true
end
