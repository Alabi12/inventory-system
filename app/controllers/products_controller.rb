class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
  
    # Filter by product name
    if params[:query].present?
      @products = @products.where("name ILIKE ?", "%#{params[:query]}%")
    end
  
    # Filter by selected category
    if params[:category].present? && params[:category] != "All"
      @products = @products.where(category: params[:category])
    end
  
    @products = @products.distinct
    @categories = Product.select(:category).distinct.pluck(:category).compact.sort
  end
  

  # GET /products/1 or /products/1.json
  def show
    @products = Product.all
  end

  # GET /products/new
  def new
    @product = Product.new  # Ensure @product is initialized
  end

  # GET /products/1/edit
  def edit
  end

  def reorder
    @products_needing_reorder = Product.includes(:inventory_item)
                                       .where('inventory_items.quantity < products.reorder_point')
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
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
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
      params.require(:product).permit(
        :name,
        :product_code,
        :category,
        :quantity,
        :price,
        :total_purchases,
        :supplier_id,
        :reorder_point,
        :stock_level,
        :low_stock_threshold,
      )
    end
end
