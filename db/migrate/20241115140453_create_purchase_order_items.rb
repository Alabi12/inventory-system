class CreatePurchaseOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_order_items do |t|
      t.references :purchase_order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end
