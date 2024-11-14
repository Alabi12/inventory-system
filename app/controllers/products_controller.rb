class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    # Fetch all products including their supplier information
    @products = Product.includes(:supplier).all
    
    # Calculate cumulative total amount for each product based on orders
    @product_totals = @products.map do |product|
      {
        product_name: product.name,
        sku: product.sku,
        price: product.price,
        stock: product.stock,
        total_purchased_amount: product.total_purchased_amount, # Use the custom method here
        supplier_name: product.supplier&.name || "No Supplier"
      }
    end

    # Low stock products (less than 5 in stock)
    @low_stock_products = Product.where("stock < ?", 5)
  end
  
  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :sku, :stock, :price, :supplier_id)
    end
end
