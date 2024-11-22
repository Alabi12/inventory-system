class StockMovementsController < ApplicationController
  before_action :set_products, only: [:new, :create]

  def index
    @stock_movements = StockMovement.includes(:product).order(created_at: :desc)
  end

  def new
    @stock_movement = StockMovement.new
  end

  def create
    @stock_movement = StockMovement.new(stock_movement_params)

    if @stock_movement.save
      redirect_to stock_movements_path, notice: 'Stock movement recorded successfully.'
    else
      flash.now[:alert] = 'Failed to record stock movement.'
      render :new
    end
  end

  private

  def stock_movement_params
    params.require(:stock_movement).permit(:product_id, :quantity, :movement_type, :change_type)
  end

  def set_products
    @products = Product.all
  end
end
