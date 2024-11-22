class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: %i[show edit update destroy]
  before_action :set_supplier, only: %i[new create]

  def index
    @purchase_orders = PurchaseOrder.all
  end

  def new
    @purchase_order = PurchaseOrder.new
    @purchase_order.purchase_order_items.build
  end

  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    if @purchase_order.save
      redirect_to @purchase_order, notice: 'Purchase Order was successfully created!'
    else
      Rails.logger.error("Purchase Order Errors: #{@purchase_order.errors.full_messages.join(', ')}")
      render :new
    end
  end

  def show
    @purchase_order_items = @purchase_order.purchase_order_items
  end

  def edit
  end

  def update
    if @purchase_order.update(purchase_order_params)
      redirect_to @purchase_order, notice: "Purchase order was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @purchase_order.destroy!
    redirect_to purchase_orders_path, status: :see_other, notice: "Purchase order was successfully destroyed."
  end

  private

  def set_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def set_supplier
    @suppliers = Supplier.all
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
