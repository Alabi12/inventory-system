# app/controllers/stock_adjustments_controller.rb
class StockAdjustmentsController < ApplicationController
  def index
    # Fetch all stock adjustments, or initialize as an empty array if none are present
    @stock_adjustments = StockAdjustment.all
  end

  def new
    @stock_adjustment = StockAdjustment.new
  end

  def create
    @stock_adjustment = StockAdjustment.new(stock_adjustment_params)
    if @stock_adjustment.save
      redirect_to products_path, notice: 'Stock adjustment successfully created.'
    else
      render :new
    end
  end

  private

  def stock_adjustment_params
    params.require(:stock_adjustment).permit(:product_id, :adjustment_type, :quantity, :location, :reason)
  end
end
