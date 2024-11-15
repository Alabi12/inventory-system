class AddThresholdToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :threshold, :integer
  end
end
