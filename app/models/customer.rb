class Customer < ApplicationRecord
  has_many :orders
  validates :name, :contact_info, presence: true
end