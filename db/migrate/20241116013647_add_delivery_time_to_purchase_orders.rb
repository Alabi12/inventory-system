class AddDeliveryTimeToPurchaseOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :purchase_orders, :delivery_time, :float
  end
end
