class AddTotalPriceToSalesOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :sales_orders, :total_price, :decimal
  end
end
