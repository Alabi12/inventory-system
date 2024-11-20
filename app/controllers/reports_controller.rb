class ReportsController < ApplicationController
  # before_action :authenticate_user! # Ensure only authenticated users can access
  
  def inventory_trends
    @inventory_trends = StockMovement.group("DATE(created_at)").sum(:quantity)
  end
  
  def sales
    @sales_orders = SalesOrder.includes(:customer, :product).all

    # Filtering logic
    if params[:start_date].present? && params[:end_date].present?
      @sales_orders = @sales_orders.where(order_date: params[:start_date]..params[:end_date])
    end

    if params[:category_id].present?
      @sales_orders = @sales_orders.joins(:product).where(products: { category_id: params[:category_id] })
    end

    if params[:customer_id].present?
      @sales_orders = @sales_orders.where(customer_id: params[:customer_id])
    end
  end

  def inventory
    @products = Product.includes(:supplier).order(:name)
  end

  def reorder_points
    @products = Product.where('quantity <= threshold')
  end

  def stock_movements
    @stock_movements = StockMovement.includes(:product).order(created_at: :desc)
  end

  def sales
    @sales_orders = SalesOrder.joins(:sales_order_items)
                              .select('sales_orders.id, sales_orders.order_date, SUM(sales_order_items.quantity * sales_order_items.price) AS total_price')
                              .group('sales_orders.id')
                              .order('sales_orders.order_date ASC')
  end  

  private

  def filter_date_range
    if params[:start_date].present? && params[:end_date].present?
      params[:start_date]..params[:end_date]
    else
      Time.current.beginning_of_month..Time.current.end_of_month
    end
  end
end
