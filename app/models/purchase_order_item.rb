class PurchaseOrderItem < ApplicationRecord
  belongs_to :purchase_order
  belongs_to :product
  
  validates :quantity, :price, presence: true
end
