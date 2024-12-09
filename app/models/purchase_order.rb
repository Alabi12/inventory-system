class PurchaseOrder < ApplicationRecord
  belongs_to :supplier
  has_many :purchase_order_items, dependent: :destroy

  validates :supplier, presence: true
  validates :order_date, presence: true

  enum status: { pending: 0, received: 1, cancelled: 2 }

  accepts_nested_attributes_for :purchase_order_items, allow_destroy: true

  def total_amount
    purchase_order_items.sum { |item| (item.quantity || 0) * (item.price || 0) }
  end

  def total_price
    purchase_order_items.sum { |item| item.quantity * (item.price || 0) }
  end
end
