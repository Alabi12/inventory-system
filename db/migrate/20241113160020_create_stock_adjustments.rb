class CreateStockAdjustments < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_adjustments do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.integer :adjustment_type

      t.timestamps
    end
  end
end
