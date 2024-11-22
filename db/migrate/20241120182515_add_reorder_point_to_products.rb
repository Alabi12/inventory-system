class AddReorderPointToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :reorder_point, :integer, default: 0
  end
end
