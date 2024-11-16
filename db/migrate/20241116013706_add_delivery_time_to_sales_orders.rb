class AddDeliveryTimeToSalesOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :sales_orders, :delivery_time, :float
  end
end
