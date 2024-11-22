class PurchaseOrderItem < ApplicationRecord
  belongs_to :purchase_order
  belongs_to :product

  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
