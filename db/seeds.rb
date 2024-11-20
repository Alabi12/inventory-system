# db/seeds.rb

# Create suppliers
supplier1 = Supplier.find_or_create_by!(name: "Supplier 1", email: "supplier1@example.com")
supplier2 = Supplier.find_or_create_by!(name: "Supplier 2", email: "supplier2@example.com")

# Create products and associate with the supplier
product1 = Product.create!(
  name: "Laptop",
  product_code: "LPT123",
  category: "Electronics",
  quantity: 10,
  price: 1200.00,
  supplier: supplier1
)

product2 = Product.create!(
  name: "Smartphone",
  product_code: "SM123",
  category: "Electronics",
  quantity: 20,
  price: 800.00,
  supplier: supplier2
)

# Add other records (e.g., customers, purchase orders, etc.)