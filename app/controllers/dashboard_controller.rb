class DashboardController < ApplicationController
  def index
    @total_products = Product.count
    @total_suppliers = Supplier.count
    @total_customers = Customer.count
    @low_stock_products = Product.where("quantity < ?", 10) # Example for low stock

    # Calculate total purchases, total sales, and profit
    @total_purchases = PurchaseOrderItem.sum('quantity * price')
    @total_sales = SalesOrderItem.sum('quantity * price')
    @profit = @total_sales - @total_purchases
  end
end
