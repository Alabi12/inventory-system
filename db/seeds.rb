# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Supplier.destroy_all
Customer.destroy_all
Product.destroy_all
PurchaseOrder.destroy_all
SalesOrder.destroy_all
StockMovement.destroy_all

# Create Suppliers
puts "Creating Suppliers..."
suppliers = Supplier.create!([
  { name: "Acme Supplies", email: "acme@example.com", phone: "123-456-7890" },
  { name: "Global Distributors", email: "global@example.com", phone: "987-654-3210" },
  { name: "TechCorp", email: "techcorp@example.com", phone: "456-789-1230" }
])

# Create Customers
puts "Creating Customers..."
customers = Customer.create!([
  { name: "John Doe", email: "johndoe@example.com", phone: "555-123-4567" },
  { name: "Jane Smith", email: "janesmith@example.com", phone: "555-987-6543" },
  { name: "ABC Enterprises", email: "contact@abc.com", phone: "555-321-6789" }
])

# Create Products
puts "Creating Products..."
products = Product.create!([
  { name: "Laptop", sku: 1, price: 1000.0, quantity: 50, threshold: 10, supplier: suppliers[0] },
  { name: "Smartphone", sku: 2, price: 800.0, quantity: 30, threshold: 5, supplier: suppliers[1] },
  { name: "Office Chair", sku: 3, price: 150.0, quantity: 20, threshold: 3, supplier: suppliers[2] }
])

# Create Purchase Orders
# Create Purchase Orders with valid suppliers
PurchaseOrder.create!([
  { supplier: suppliers[0], order_date: Date.new(2022, 2, 1), total_amount: 5000.0, status: 'received' },
  { supplier: suppliers[1], order_date: Date.new(2022, 3, 15), total_amount: 3000.0, status: 'pending' }
])

# Create Stock Movements for Purchase Orders
puts "Creating Stock Movements for Purchase Orders..."
StockMovement.create!([
  { product: products[0], quantity: 20, movement_type: "restock", purchase_order: purchase_orders[0]},
  { product: products[1], quantity: 10, movement_type: "restock", purchase_order: purchase_orders[1] }
])

# Create Sales Orders
puts "Creating Sales Orders..."
sales_orders = SalesOrder.create!([
  { customer: customers[0], date: 3.days.ago, total_amount: 2000.0 },
  { customer: customers[1], date: 1.week.ago, total_amount: 1500.0 }
])

# Create Order Items for Sales Orders
puts "Creating Order Items for Sales Orders..."
OrderItem.create!([
  { sales_order: sales_orders[0], product: products[0], quantity: 2, price: products[0].price },
  { sales_order: sales_orders[1], product: products[1], quantity: 1, price: products[1].price }
])

# Create Stock Movements for Sales Orders
puts "Creating Stock Movements for Sales Orders..."
StockMovement.create!([
  { product: products[0], quantity: 2, movement_type: "sale", sales_order: sales_orders[0], created_at: 3.days.ago },
  { product: products[1], quantity: 1, movement_type: "sale", sales_order: sales_orders[1], created_at: 1.week.ago }
])

puts "Seed data created successfully!"