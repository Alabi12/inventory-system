class StockAdjustment < ApplicationRecord
  belongs_to :product
  validates :quantity, presence: true
  enum adjustment_type: { addition: 0, removal: 1, transfer: 2 }

  after_save :update_product_stock

  private

  def update_product_stock
    if addition?
      product.increment!(:stock, quantity)
    elsif removal?
      product.decrement!(:stock, quantity)
    end
  end
end
