class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all.includes(:product, :customer)
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  def create
    @order = Order.new(order_params)

    # Ensure the product is associated before setting the price
    if @order.product
      @order.price = @order.product.price # Set the price from the product's price
    else
      # Handle the case where the product is not found (e.g., invalid product_id)
      flash[:error] = "Product not found."
      render :new
      return
    end

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_path, status: :see_other, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.

    def order_params
      params.require(:order).permit(:product_id, :customer_id, :status, :quantity, :price)
    end
end
