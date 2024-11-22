class RemoveSupplierIdFromSalesOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :sales_orders, :supplier_id, :integer
  end
end
