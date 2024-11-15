class CreatePurchaseOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_orders do |t|
      t.references :supplier, null: false, foreign_key: true
      t.integer :status
      t.date :order_date
      t.date :received_date

      t.timestamps
    end
  end
end
