products = Product.all

products.each do |product|
  # Simulate stock received
  product.stock_movements.create!(quantity: 50, movement_type: 'received', created_at: Time.now)

  # Simulate stock sold
  product.stock_movements.create!(quantity: 10, movement_type: 'sold', created_at: Time.now)
end

product = Product.create!(name: "Sample Product", reorder_point: 10, price: 100.0)

purchase_order = PurchaseOrder.create!(
  supplier: Supplier.create!(name: "Supplier A"),
  order_date: Date.today,
  status: "pending"
)

purchase_order.purchase_order_items.create!(
  product: product,
  quantity: 10,
  price: product.price
)
