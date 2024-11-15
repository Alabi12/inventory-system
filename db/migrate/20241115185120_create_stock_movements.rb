class CreateStockMovements < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_movements do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :change_quantity
      t.string :change_type
      t.string :reason

      t.timestamps
    end
  end
end
