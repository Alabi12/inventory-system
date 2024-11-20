class SalesOrder < ApplicationRecord
  belongs_to :customer
  belongs_to :supplier, optional: true
  has_many :sales_order_items, dependent: :destroy
  
  accepts_nested_attributes_for :sales_order_items, allow_destroy: true
  
  validates :customer_id, :status, :order_date, presence: true
  
  validates :status, :order_date, presence: true

  before_save :set_defaults

  before_save :calculate_total_price


private

def calculate_total_price
  self.total_price = sales_order_items.sum('quantity * price')
end

def set_defaults
  self.total_amount ||= 0
  self.delivery_time ||= 0
  end
end
