class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[ show edit update destroy ]

  # GET /suppliers or /suppliers.json
  def index
    @suppliers = Supplier.all  # Fetch all suppliers (or adjust query as necessary)
  end
  
  def supplier_performance
    @supplier_performance = Supplier.joins(:purchase_orders)
                                     .group("suppliers.id")
                                     .select("suppliers.name, AVG(purchase_orders.delivery_time) AS avg_delivery_time")
  end
  
  # GET /suppliers/1 or /suppliers/1.json
  def show
    @supplier = Supplier.find(params[:id])
    
    # Ensure @supplier_performance is an array and not an integer.
    @supplier_performance = Supplier.joins(:purchase_orders, :sales_orders)
                                     .select("suppliers.name, AVG(purchase_orders.delivery_time) AS avg_purchase_delivery_time, AVG(sales_orders.delivery_time) AS avg_sales_delivery_time")
                                     .where(id: @supplier.id)
                                     .group("suppliers.id")
    
    # Fetch the first record since it's a single supplier's performance.
    @supplier_performance = @supplier_performance.first
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
      params.require(:supplier).permit(:name, :email, :phone, :address)
    end
end
