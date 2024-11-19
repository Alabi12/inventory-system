class PurchaseOrder < ApplicationRecord
  belongs_to :supplier
  belongs_to :customer

  has_many :purchase_order_items
  has_many :products, through: :purchase_order_items

  validates :order_date, :status, presence: true

  enum status: { pending: 0, received: 1, cancelled: 2 }

  validates :supplier, presence: true

  has_many :purchase_order_items, dependent: :destroy
  accepts_nested_attributes_for :purchase_order_items, allow_destroy: true
end
