class SalesOrdersController < ApplicationController
  before_action :set_sales_order, only: %i[show edit update destroy]

  # GET /sales_orders
  def index
    @sales_orders = SalesOrder.includes(:customer, :sales_order_items).distinct
  end

  # GET /sales_orders/1
  def show
    @sales_orders = SalesOrder.all
    @sales_order_items = @sales_order.sales_order_items
  end

  # GET /sales_orders/new
  def new
    @sales_order = SalesOrder.new
    @sales_order.sales_order_items.build
  end

  # POST /sales_orders
  def create
    @sales_order = SalesOrder.new(sales_order_params)
  
    if @sales_order.save
      redirect_to @sales_order, notice: "Sales order was successfully created."
    else
      flash[:alert] = @sales_order.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sales_orders/1
  def update
    if @sales_order.update(sales_order_params)
      redirect_to @sales_order, notice: 'Sales Order was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @sales_order.destroy
    redirect_to sales_orders_url, notice: 'Sales order was successfully deleted.'
  end

  private

  def set_sales_order
    @sales_order = SalesOrder.find(params[:id])
  end


  def sales_order_params
    params.require(:sales_order).permit(
      :customer_id,
      :status,
      :order_date,
      :received_date,
      :total_amount,
      :delivery_time,
      sales_order_items_attributes: [:id, :product_id, :quantity, :price, :_destroy]
    )
  end
end