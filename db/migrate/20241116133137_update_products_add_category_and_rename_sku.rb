class UpdateProductsAddCategoryAndRenameSku < ActiveRecord::Migration[7.1]
  def change
    # Add the category column
    add_column :products, :category, :string

    # Rename the SKU column to product_code
    rename_column :products, :sku, :product_code
  end
end
