class AddDateToPurchaseOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :purchase_orders, :date, :date
  end
end
