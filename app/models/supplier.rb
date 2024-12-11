class Supplier < ApplicationRecord
  has_many :purchase_orders
  has_many :products, dependent: :destroy
  has_and_belongs_to_many :products

  validates :name, :email, :phone, presence: true

  has_many :purchase_order_items, through: :purchase_orders
  
  # validates :products, presence: true, if: :products_required?

  def products_required?
    true
  end
end
