class InventoryItemsController < ApplicationController
  before_action :set_inventory_item, only: [:show, :edit, :update, :destroy]

  def index
    @inventory_items = InventoryItem.includes(:product)
  end
  

  def show
    @inventory_item = InventoryItem.find(params[:id])
  end

  def new
    @inventory_item = InventoryItem.new
    @products = Product.all # Ensure this line is present to fetch products
  end  

  def create
    @inventory_item = InventoryItem.new(inventory_item_params)
    if @inventory_item.save
      redirect_to @inventory_item, notice: 'Inventory item was successfully created.'
    else
      render :new
    end
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
