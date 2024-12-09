class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: %i[show edit update destroy]

  def index
    @purchase_orders = PurchaseOrder.all
  end

  def new
    @purchase_order = PurchaseOrder.new
    @purchase_order.purchase_order_items.build # Initializes one item
  end

  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    if @purchase_order.purchase_order_items.any? && @purchase_order.save
      redirect_to @purchase_order, notice: 'Purchase order was successfully created.'
    else
      flash.now[:alert] = 'Please add at least one item to the order.' if @purchase_order.purchase_order_items.empty?
      render :new
    end
  end

  def show
  end

  def edit
    @purchase_order.purchase_order_items.build if @purchase_order.purchase_order_items.empty?
  end

  def update
    if @purchase_order.update(purchase_order_params)
      redirect_to @purchase_order, notice: "Purchase order was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @purchase_order.destroy
    redirect_to purchase_orders_url, notice: "Purchase order was successfully destroyed."
  end

  private

  def set_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def purchase_order_params
    params.require(:purchase_order).permit(
      :supplier_id,
      :order_date,
      :received_date,
      :status,
      purchase_order_items_attributes: [:id, :product_id, :quantity, :price, :_destroy]
    )
  end
end
