json.extract! purchase_order, :id, :supplier_id, :status, :order_date, :received_date, :created_at, :updated_at
json.url purchase_order_url(purchase_order, format: :json)
