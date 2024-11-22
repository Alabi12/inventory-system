class AddTotalPurchasesToPurchaseOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :purchase_orders, :total_purchases, :decimal
  end
end
