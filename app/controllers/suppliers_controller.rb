class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[ show edit update destroy ]

  # GET /suppliers or /suppliers.json
  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
    # Fetch total purchased amount for all orders of this supplier's products
    @total_purchased_amount = @supplier.orders.joins(:product).sum('orders.quantity * products.price')
    # Fetch all orders for this supplier's products
    @orders = @supplier.orders.includes(:product)
  end

  # GET /suppliers/new
  def new
    @supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
  end

  # POST /suppliers or /suppliers.json
  def create
    @supplier = Supplier.new(supplier_params)

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to @supplier, notice: "Supplier was successfully created." }
        format.json { render :show, status: :created, location: @supplier }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suppliers/1 or /suppliers/1.json
  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to @supplier, notice: "Supplier was successfully updated." }
        format.json { render :show, status: :ok, location: @supplier }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1 or /suppliers/1.json
  def destroy
    @supplier = Supplier.find(params[:id])
  
    if @supplier.products.any?
      flash[:alert] = "Cannot delete supplier with associated products."
      redirect_to suppliers_path
    else
      @supplier.destroy
      flash[:notice] = "Supplier successfully deleted."
      redirect_to suppliers_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supplier_params
      params.require(:supplier).permit(:name, :contact_info)
    end
end
