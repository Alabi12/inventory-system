class Stock < ApplicationRecord
  belongs_to :product

  validates :location, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
