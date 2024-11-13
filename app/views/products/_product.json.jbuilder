json.extract! product, :id, :name, :sku, :price, :stock, :supplier_id, :created_at, :updated_at
json.url product_url(product, format: :json)
