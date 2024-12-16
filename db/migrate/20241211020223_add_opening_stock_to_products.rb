class AddOpeningStockToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :opening_stock, :integer
  end
end
