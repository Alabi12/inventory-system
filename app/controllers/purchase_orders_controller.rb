class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: %i[ show edit update destroy ]
  before_action :set_supplier, only: [:new, :create]

  # GET /purchase_orders or /purchase_orders.json
  def index
    @purchase_orders = PurchaseOrder.all
  end

  def new
    @purchase_order = PurchaseOrder.new
    @purchase_order.purchase_order_items.build  # Initialize at least one item
  end

  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    if @purchase_order.save
      redirect_to @purchase_order, notice: 'Purchase Order was successfully created.'
    else
      render :new
    end
  end

  # GET /purchase_orders/1 or /purchase_orders/1.json
  def show
    @purchase_order = PurchaseOrder.find(params[:id])  # Find the specific purchase order by ID
  end

  # GET /purchase_orders/1/edit
  def edit
  end

  # POST /purchase_orders or /purchase_orders.json
  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)

    if @purchase_order.save
      # If the order is saved successfully, redirect to the show page
      redirect_to @purchase_order, notice: 'Purchase Order was successfully created!'
    else
      # If there are errors, render the form again with the errors
      render :new
    end
  end

  # PATCH/PUT /purchase_orders/1 or /purchase_orders/1.json
  def update
    respond_to do |format|
      if @sales_order.update(sales_order_params)
        format.html { redirect_to @sales_order, notice: "Sales order updated successfully." }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@sales_order, partial: "sales_orders/form", locals: { sales_order: @sales_order }) }
      end
    end
  end

  # DELETE /purchase_orders/1 or /purchase_orders/1.json
  def destroy
    @purchase_order.destroy!

    respond_to do |format|
      format.html { redirect_to purchase_orders_path, status: :see_other, notice: "Purchase order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end

    def set_supplier
      @suppliers = Supplier.all
    end

    # Only allow a list of trusted parameters through.
    def purchase_order_params
      params.require(:purchase_order).permit(
        :customer_id, 
        :order_date, 
        :status,
        :supplier_id, 
        purchase_order_items_attributes: [:id, :product_id, :quantity, :_destroy]
      )
    end
end
