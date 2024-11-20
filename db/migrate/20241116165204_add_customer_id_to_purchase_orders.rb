class AddCustomerIdToPurchaseOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :purchase_orders, :customer_id, :bigint
    add_index :purchase_orders, :customer_id
  end
end
