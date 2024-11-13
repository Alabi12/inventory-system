class Product < ApplicationRecord
  validates :name, :sku, :price, :stock, presence: true
  validates :sku, uniqueness: true
  has_many :orders
  belongs_to :supplier

  # Example of a scope for finding low stock products
  scope :low_stock, -> { where("stock < ?", 10) }
end
