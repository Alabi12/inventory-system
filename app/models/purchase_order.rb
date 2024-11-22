class PurchaseOrder < ApplicationRecord
  belongs_to :supplier

  has_many :purchase_order_items
  has_many :products, through: :purchase_order_items

  validates :order_date, presence: true
  validates :received_date, presence: true

  enum status: { pending: 0, received: 1, cancelled: 2 }

  validates :supplier, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  has_many :purchase_order_items, dependent: :destroy

  accepts_nested_attributes_for :purchase_order_items, allow_destroy: true

  def total_amount
    purchase_order_items.sum { |item| (item.quantity || 0) * (item.price || 0) }
  end

  def total_price
    purchase_order_items.sum { |item| item.quantity * (item.price || 0) }
  end
end
