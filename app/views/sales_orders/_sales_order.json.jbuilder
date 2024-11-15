json.extract! sales_order, :id, :customer_id, :status, :order_date, :delivery_date, :created_at, :updated_at
json.url sales_order_url(sales_order, format: :json)
