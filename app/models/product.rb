class Product < ApplicationRecord
  after_save :check_stock_level
  belongs_to :supplier
  has_many :stock_movements, dependent: :destroy
  has_many :purchase_order_items
  has_many :sales_order_items
  has_one :inventory_item
  has_many :purchase_orders, through: :purchase_order_items
  has_many :sales_orders, through: :sales_order_items
  has_and_belongs_to_many :suppliers
  
  validates :product_code, presence: true, uniqueness: true
  validates :name, :product_code, :category, :quantity, :price, presence: true
  validates :reorder_point, numericality: { greater_than_or_equal_to: 0 }

   # Method to check if product's inventory is below the reorder point
   def needs_reorder?
    current_inventory = inventory_item&.quantity.to_i
    current_inventory < reorder_point.to_i
  end

  def current_balance
    stock_movements.received.sum(:quantity) - stock_movements.sold.sum(:quantity)
  end

  def search_data
    {
      name: name,
      product_code: product_code,
      category: category,
      stock_level: stock_level,
    }
  end
 
  def check_stock_level
    if stock_level.present? && reorder_point.present? && stock_level <= reorder_point
      # Notify reorder (this could be a method or another action)
      notify_reorder
    end
  end
end
