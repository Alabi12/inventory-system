class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.decimal :price
      t.integer :stock_level
      t.integer :low_stock_threshold

      t.timestamps
    end
  end
end
