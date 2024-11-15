class DashboardController < ApplicationController
  def index
    @total_products = Product.count
    @total_suppliers = Supplier.count
    @total_customers = Customer.count
    @low_stock_products = Product.where('quantity < ?', 10)
    @sales_data = SalesOrder.group(:status).count
  end
end
