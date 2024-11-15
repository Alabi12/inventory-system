class CreateSalesOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :sales_orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :status
      t.date :order_date
      t.date :delivery_date

      t.timestamps
    end
  end
end
