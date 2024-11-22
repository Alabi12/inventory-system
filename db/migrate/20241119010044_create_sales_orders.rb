class CreateSalesOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :sales_orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :status
      t.date :order_date
      t.date :received_date
      t.decimal :total_amount
      t.decimal :delivery_time

      t.timestamps
    end
  end
end
