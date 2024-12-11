class PurchaseOrder < ApplicationRecord
  belongs_to :supplier
  belongs_to :sales_order, optional: true # Assuming PurchaseOrder belongs to SalesOrder

  has_many :purchase_order_items, dependent: :destroy

  validates :supplier, :order_date, presence: true

  enum status: { pending: 0, received: 1, cancelled: 2 }

  accepts_nested_attributes_for :purchase_order_items, allow_destroy: true

  # Calculates total price from all associated purchase order items
  def total_price
    purchase_order_items.sum { |item| item.quantity * item.price }
  end

  after_save :update_sales_order_total
  after_destroy :update_sales_order_total

  private

  # Updates the associated SalesOrder's total price (if there is an associated SalesOrder)
  def update_sales_order_total
    sales_order&.calculate_total_price if sales_order.present?
  end
end
