class AddSupplierIdToSalesOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :sales_orders, :supplier_id, :integer
  end
end
