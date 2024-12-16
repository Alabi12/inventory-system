class InventoryItemsController < ApplicationController
  before_action :set_inventory_item, only: [:show, :edit, :update, :destroy]

  def index
    @inventory_items = InventoryItem.includes(:product)
  end
  

  def show
    @inventory_item = InventoryItem.find(params[:id])
  end

  def new
    @products = Product.all
    @inventory_items = @products.map do |product|
      {
        product: product,
        opening_stock: product.stock_movements.where(movement_type: 'opening').sum(:quantity)
      }
    end
  end

  def create
    params[:inventory_items].each do |item|
      product_id = item[:product_id]
      opening_stock = item[:opening_stock].to_i

      # Create or update stock movements for opening inventory
      StockMovement.create!(
        product_id: product_id,
        movement_type: 'opening',
        quantity: opening_stock,
        warehouse_id: item[:warehouse_id],
        created_at: Time.zone.now.beginning_of_day
      )
    end
    redirect_to reports_inventory_path, notice: 'Opening inventory updated successfully!'
  end

  def edit
  end

  def update
    if @inventory_item.update(inventory_item_params)
      redirect_to @inventory_item, notice: 'Inventory item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @inventory_item.destroy
    redirect_to inventory_items_url, notice: 'Inventory item was successfully destroyed.'
  end

  private

  def set_inventory_item
    @inventory_item = InventoryItem.find(params[:id])
  end

  def inventory_item_params
    params.require(:inventory_item).permit(:name, :quantity, :product_id, :supplier_id)
  end

  def inventory_item_params
    params.require(:inventory_item).permit(:name, :quantity, :product_id, :supplier_id)
  end
end
