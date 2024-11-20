class AddPriceToPurchaseOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_column :purchase_order_items, :price, :decimal
  end
end
