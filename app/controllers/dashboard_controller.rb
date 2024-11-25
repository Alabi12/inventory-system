class DashboardController < ApplicationController
  def index
    @total_products = Product.count
    @total_suppliers = Supplier.count
    @total_customers = Customer.count
    @low_stock_products = Product.where('quantity < ?', 10)
    @sales_data = SalesOrder.group_by_day(:order_date).sum(:total_price)
  end
end
