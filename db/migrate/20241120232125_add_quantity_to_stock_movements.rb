class AddQuantityToStockMovements < ActiveRecord::Migration[7.1]
  def change
    add_column :stock_movements, :quantity, :integer
  end
end
