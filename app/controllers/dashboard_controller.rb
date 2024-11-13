class DashboardController < ApplicationController
  def index
    @low_stock_products = Product.low_stock || [] # Ensure @low_stock_products is an array, even if no low-stock products are found
    @recent_orders = Order.order(created_at: :desc).limit(10) || [] # Ensure @recent_orders is an array
  end
end
