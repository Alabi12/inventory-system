class ReportsController < ApplicationController
  def dashboard
    # Query products with stock quantity <= 40
    @low_stock_products = Product.joins(:inventory_item)
                                  .where('inventory_items.quantity <= ?', 40)
                                  .order('inventory_items.quantity ASC')

    # Other data you may need on the dashboard
    @total_products = Product.count
    @total_suppliers = Supplier.count
    @total_customers = Customer.count
  end

  def inventory_trends
    # Fetch inventory trends, grouping by the creation date and summing quantities
    @inventory_trends = StockMovement.group("DATE(created_at)").sum(:quantity)
  end
  
  def sales
    # Sales by product
    @sales_by_product = SalesOrderItem
                          .joins(:product)
                          .select('products.name, SUM(sales_order_items.quantity * sales_order_items.price) AS total_sales')
                          .group('products.name')
                          .order('total_sales DESC')

    # Sales by customer
    @sales_by_customer = SalesOrder
                          .joins(:sales_order_items)
                          .select('sales_orders.customer_id, customers.name, SUM(sales_order_items.quantity * sales_order_items.price) AS total_sales')
                          .joins(:customer)
                          .group('sales_orders.customer_id, customers.name')
                          .order('total_sales DESC')

    # Initialize sales by date if not already set
    @sales_by_date = SalesOrder
                      .joins(:sales_order_items)
                      .select('DATE(sales_orders.order_date) AS date, SUM(sales_order_items.quantity * sales_order_items.price) AS total_sales')
                      .group('date')
                      .order('date ASC')

    # Ensure @sales_by_date is an empty array if no data is found
    @sales_by_date = @sales_by_date.presence || []

    # Other sales-related variables
    @total_sales = SalesOrderItem.sum('quantity * price')
    @profit = @total_sales - PurchaseOrderItem.sum('quantity * price')
  end

  def inventory
    # Get all products, including supplier information, ordered by name
    @products = Product.includes(:supplier).order(:name)
  end

  def reorder_points
    # Fetch products that need reordering
    @products_needing_reorder = Product.includes(:inventory_item).select { |product| product.needs_reorder? }
  end

  def stock_movements
    # Optional: Handle search by product name
    @search_query = params[:search]
    products = Product.includes(:stock_movements)

    # If search query is present, filter by product name (case-insensitive)
    products = products.where('name ILIKE ?', "%#{@search_query}%") if @search_query.present?

    # Prepare stock movement report data for each product
    @products = products.map do |product|
      # Summing received and sold quantities for stock movements
      received_quantity = product.stock_movements.received.sum(:quantity)
      sold_quantity = product.stock_movements.sold.sum(:quantity)
      current_inventory = received_quantity - sold_quantity

      # Returning relevant data for the report
      {
        name: product.name,
        received_quantity: received_quantity,
        sold_quantity: sold_quantity,
        current_inventory: current_inventory
      }
    end
  end

  private

  # Helper method to filter the date range for reports
  def filter_date_range
    if params[:start_date].present? && params[:end_date].present?
      params[:start_date]..params[:end_date]
    else
      Time.current.beginning_of_month..Time.current.end_of_month
    end
  end
end
