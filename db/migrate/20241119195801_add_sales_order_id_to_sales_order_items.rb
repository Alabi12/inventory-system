class AddSalesOrderIdToSalesOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_column :sales_order_items, :sales_order_id, :bigint
  end
end
