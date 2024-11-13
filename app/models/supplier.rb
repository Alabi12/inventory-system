class Supplier < ApplicationRecord
  has_many :products
  validates :name, :contact_info, presence: true
end
