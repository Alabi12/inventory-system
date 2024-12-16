class AddOpeningMovementTypeToStockMovements < ActiveRecord::Migration[7.1]
  def change
    change_column :stock_movements, :movement_type, :string # Ensure it's stored as a string
  end
end
