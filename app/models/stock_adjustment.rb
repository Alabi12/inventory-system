# app/models/stock_adjustment.rb
class StockAdjustment < ApplicationRecord
  belongs_to :product

  enum adjustment_type: { add: 'add', remove: 'remove', transfer: 'transfer' }

  after_create :apply_adjustment

  private

  def apply_adjustment
    stock = product.stocks.find_or_initialize_by(location: location)
    case adjustment_type
    when 'add'
      stock.quantity += quantity
    when 'remove'
      stock.quantity -= quantity
    end
    stock.save
  end
end
