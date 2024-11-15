class ReportsController < ApplicationController
  # before_action :authenticate_user! # Ensure only authenticated users can access
  
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
    @start_date = params[:start_date].presence || 30.days.ago.to_date
    @end_date = params[:end_date].presence || Date.today

    @sales_orders = SalesOrder.includes(:customer, :products)
                              .where(created_at: @start_date..@end_date)
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
