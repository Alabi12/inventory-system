class CreateInventoryItems < ActiveRecord::Migration[7.1]
  def change
    create_table :inventory_items do |t|
      t.string :name
      t.integer :quantity
      t.integer :product_id
      t.integer :supplier_id

      t.timestamps
    end
  end
end
