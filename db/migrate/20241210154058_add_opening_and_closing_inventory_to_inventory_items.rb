class AddOpeningAndClosingInventoryToInventoryItems < ActiveRecord::Migration[7.1]
  def change
    add_column :inventory_items, :opening_inventory, :integer
    add_column :inventory_items, :closing_inventory, :integer
  end
end
