json.extract! product, :id, :name, :sku, :price, :stock_level, :low_stock_threshold, :created_at, :updated_at
json.url product_url(product, format: :json)
