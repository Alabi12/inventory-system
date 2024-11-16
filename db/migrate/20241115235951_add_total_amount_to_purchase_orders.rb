class AddTotalAmountToPurchaseOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :purchase_orders, :total_amount, :decimal
  end
end
