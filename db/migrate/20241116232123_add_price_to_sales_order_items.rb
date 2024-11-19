class AddPriceToSalesOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_column :sales_order_items, :price, :decimal
  end
end
