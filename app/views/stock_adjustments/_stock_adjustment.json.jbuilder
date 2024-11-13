json.extract! stock_adjustment, :id, :product_id, :quantity, :adjustment_type, :created_at, :updated_at
json.url stock_adjustment_url(stock_adjustment, format: :json)
