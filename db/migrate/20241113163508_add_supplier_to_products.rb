class AddSupplierToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :supplier, null: false, foreign_key: true
  end
end
