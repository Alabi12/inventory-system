json.extract! customer, :id, :name, :contact_info, :created_at, :updated_at
json.url customer_url(customer, format: :json)
