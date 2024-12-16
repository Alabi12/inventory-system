class AddWarehouseIdToStockMovements < ActiveRecord::Migration[7.1]
  def change
    add_column :stock_movements, :warehouse_id, :integer
  end
end
