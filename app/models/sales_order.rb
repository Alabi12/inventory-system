class SalesOrder < ApplicationRecord
  belongs_to :customer
  has_many :sales_order_items, dependent: :destroy

  accepts_nested_attributes_for :sales_order_items, allow_destroy: true

  validates :customer_id, :status, :order_date, presence: true

  before_save :set_defaults
  before_save :calculate_total_price # Automatically calculates total price before save

  # Public method to calculate total price
  def calculate_total_price
    self.total_price = sales_order_items.sum(&:total_price)
  end

  # Getter for total amount
  def total_amount
    sales_order_items.sum(&:total_price)
  end

  private

  # Helper to set default values
  def set_defaults
    self.total_price ||= 0.0
  end
end
