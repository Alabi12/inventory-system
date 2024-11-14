class AddDestinationToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :destination, :string, null: false, default: "warehouse"
  end
end
