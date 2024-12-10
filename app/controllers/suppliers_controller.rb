class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[ show edit update destroy ]

  # GET /suppliers or /suppliers.json
  def index
    @suppliers = Supplier.all

    @purchase_orders = PurchaseOrder.includes(:supplier, :purchase_order_items).all

    if params[:query].present?
      @suppliers = Supplier.joins(:products).where(
        "suppliers.name ILIKE :query OR products.name ILIKE :query",
        query: "%#{params[:query]}%"
      ).distinct
    else
      @suppliers = Supplier.all
    end
  end
  
  def supplier_performance
    @supplier_performance = Supplier.joins(:purchase_orders)
                                     .group("suppliers.id")
                                     .select("suppliers.name, AVG(purchase_orders.delivery_time) AS avg_delivery_time")
  end
  
  # GET /suppliers/1 or /suppliers/1.json
  def show
    @supplier = Supplier.find(params[:id])
  end
  
  # GET /suppliers/new
  def new
    @supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
  end

 # In the SuppliersController, update both the `create` and `update` actions:

 def create
  @supplier = Supplier.new(supplier_params)

  # Sanitize the product_ids to remove invalid ones
  if params[:supplier][:product_ids].present?
    # Remove any 0 or nil IDs
    sanitized_product_ids = params[:supplier][:product_ids].reject { |id| id.to_i == 0 || id.nil? }
    @supplier.product_ids = sanitized_product_ids
  end

  respond_to do |format|
    if @supplier.save
      format.html { redirect_to @supplier, notice: "Supplier was successfully created." }
      format.json { render :show, status: :created, location: @supplier }
    else
      format.html { render :new }
      format.json { render json: @supplier.errors, status: :unprocessable_entity }
    end
  end
end

def update
  @supplier = Supplier.find(params[:id])

  # Sanitize the product_ids to remove invalid ones (id = 0 or nil)
  if params[:supplier][:product_ids].present?
    sanitized_product_ids = params[:supplier][:product_ids].reject { |id| id.to_i == 0 || id.nil? }
    @supplier.product_ids = sanitized_product_ids
  end

  respond_to do |format|
    if @supplier.update(supplier_params)
      format.html { redirect_to @supplier, notice: "Supplier was successfully updated." }
      format.json { render :show, status: :ok, location: @supplier }
    else
      format.html { render :edit }
      format.json { render json: @supplier.errors, status: :unprocessable_entity }
    end
  end
end 

  # DELETE /suppliers/1 or /suppliers/1.json
  def destroy
    @supplier.destroy!

    respond_to do |format|
      format.html { redirect_to suppliers_path, status: :see_other, notice: "Supplier was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supplier_params
      params.require(:supplier).permit(:name, :email, :phone, :address, product_ids: [])
    end
end
