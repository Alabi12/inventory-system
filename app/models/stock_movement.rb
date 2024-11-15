class StockMovement < ApplicationRecord
  belongs_to :product

  validates :change_quantity, presence: true
  validates :change_type, presence: true, inclusion: { in: %w[addition removal] }
end
