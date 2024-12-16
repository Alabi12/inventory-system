class ChangeMovementTypeToStringInStockMovements < ActiveRecord::Migration[7.1]
  def change
    change_column :stock_movements, :movement_type, :string
  end
end
