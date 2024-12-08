class StockMovementsController < ApplicationController
  before_action :set_stock_movement, only: [:show, :edit, :update, :destroy]
  before_action :set_products, only: [:new, :create, :edit, :update]

  def index
    @stock_movements = StockMovement.includes(:product).order(created_at: :desc)
  end

  def show
    # @stock_movement is already set by the before_action
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

  def edit
    # @stock_movement is already set by the before_action
  end

  def update
    if @stock_movement.update(stock_movement_params)
      redirect_to stock_movement_path(@stock_movement), notice: 'Stock movement updated successfully.'
    else
      flash.now[:alert] = 'Failed to update stock movement.'
      render :edit
    end
  end

  def destroy
    @stock_movement.destroy
    redirect_to stock_movements_path, notice: 'Stock movement deleted successfully.'
  end

  private

  def stock_movement_params
    params.require(:stock_movement).permit(:product_id, :quantity, :movement_type, :change_type)
  end

  def set_stock_movement
    @stock_movement = StockMovement.find(params[:id])
  end

  def set_products
    @products = Product.all
  end
end
