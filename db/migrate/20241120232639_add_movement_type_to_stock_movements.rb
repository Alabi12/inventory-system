class AddMovementTypeToStockMovements < ActiveRecord::Migration[7.1]
  def change
    add_column :stock_movements, :movement_type, :string
  end
end
