class Product < ApplicationRecord
  validates :name, :sku, :price, :stock, presence: true
  validates :sku, uniqueness: true
  has_many :orders
  belongs_to :supplier
  has_many :stocks
  has_many :stock_adjustments

  attribute :low_stock_threshold, :integer, default: 10

  def low_stock?
    total_stock < low_stock_threshold
  end

  def total_stock
    stocks.sum(:quantity)
  end

    # Calculate the total purchased amount based on orders
    def total_purchased_amount
      orders.sum("quantity * price")
    end

  # Example of a scope for finding low stock products
  scope :low_stock, -> { where("stock < ?", 10) }
end
