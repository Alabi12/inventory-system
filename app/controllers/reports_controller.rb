class ReportsController < ApplicationController
  before_action :set_date_range, only: %i[inventory_analysis]

  # Dashboard for key metrics
  def dashboard
    @low_stock_products = Product.joins(:inventory_item)
                                  .where('inventory_items.quantity <= ?', 40)
                                  .order('inventory_items.quantity ASC')

    @total_products = Product.count
    @total_suppliers = Supplier.count
    @total_customers = Customer.count
  end

  # Inventory trends over time
  def inventory_trends
    @inventory_trends = StockMovement.group("DATE(created_at)").sum(:quantity)
  end

  # Sales reports
  def sales
    @sales_by_product = fetch_sales_by_product
    @sales_by_customer = fetch_sales_by_customer
    @sales_by_date = fetch_sales_by_date.presence || []

    @total_sales = SalesOrderItem.sum('quantity * price')
    @profit = calculate_profit
  end

  # Inventory report
  def inventory
    @products = Product.includes(:supplier).order(:name)
  end

  # Products needing reorder
  def reorder_points
    @products_needing_reorder = Product.includes(:inventory_item)
                                       .select { |product| product.needs_reorder? }
  end

  # Stock movement report
  def stock_movements
    @search_query = params[:search]
    products = Product.includes(:stock_movements)
    products = products.where('name ILIKE ?', "%#{@search_query}%") if @search_query.present?

    @products = products.map { |product| stock_movement_summary(product) }
  end

  # Inventory analysis using FIFO
  def inventory_analysis
    @inventory_analysis = Product.includes(:stock_movements).map do |product|
      # Opening stock from 'opening' movements
      opening_stock = product.stock_movements.where(movement_type: 'opening').sum(:quantity)
      incoming_stock = calculate_incoming_stock(product, @start_date, @end_date)
      outgoing_stock = calculate_outgoing_stock(product, @start_date, @end_date)
      closing_stock = opening_stock + incoming_stock - outgoing_stock
  
      # Record the opening inventory in the database (if needed)
      product.update(opening_stock: opening_stock) if product.respond_to?(:opening_stock)
  
      {
        product_name: product.name,
        opening_stock: opening_stock,
        incoming_stock: incoming_stock,
        outgoing_stock: outgoing_stock,
        closing_stock: closing_stock
      }
    end
  end  

  private

  # Helper to set the date range
  def set_date_range
    @start_date = params[:start_date].present? ? params[:start_date].to_date.beginning_of_day : Time.current.beginning_of_month
    @end_date = params[:end_date].present? ? params[:end_date].to_date.end_of_day : Time.current.end_of_month
  end

  # Fetch sales by product
  def fetch_sales_by_product
    SalesOrderItem
      .joins(:product)
      .select('products.name, SUM(sales_order_items.quantity * sales_order_items.price) AS total_sales')
      .group('products.name')
      .order('total_sales DESC')
  end

  # Fetch sales by customer
  def fetch_sales_by_customer
    SalesOrder
      .joins(:customer, :sales_order_items)
      .select('customers.name, SUM(sales_order_items.quantity * sales_order_items.price) AS total_sales')
      .group('customers.name')
      .order('total_sales DESC')
  end

  # Fetch sales by date
  def fetch_sales_by_date
    SalesOrder
      .joins(:sales_order_items)
      .select('DATE(sales_orders.order_date) AS date, SUM(sales_order_items.quantity * sales_order_items.price) AS total_sales')
      .group('date')
      .order('date ASC')
  end

  # Calculate profit
  def calculate_profit
    @total_sales - PurchaseOrderItem.sum('quantity * price')
  end

  # Summarize stock movement
  def stock_movement_summary(product)
    received_quantity = product.stock_movements.received.sum(:quantity)
    sold_quantity = product.stock_movements.sold.sum(:quantity)
    current_inventory = received_quantity - sold_quantity

    {
      name: product.name,
      received_quantity: received_quantity,
      sold_quantity: sold_quantity,
      current_inventory: current_inventory
    }
  end

  # Calculate opening stock
  def calculate_opening_stock(product, start_date)
    product.stock_movements.where("created_at < ?", start_date).sum(:quantity)
  end

  # Calculate incoming stock
  def calculate_incoming_stock(product, start_date, end_date)
    product.stock_movements.received.where(created_at: start_date..end_date).sum(:quantity)
  end

  # Calculate outgoing stock
  def calculate_outgoing_stock(product, start_date, end_date)
    product.stock_movements.sold.where(created_at: start_date..end_date).sum(:quantity)
  end
end