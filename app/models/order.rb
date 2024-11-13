class Order < ApplicationRecord
  belongs_to :product
  belongs_to :customer
  
  # Define enum for status with values like pending, completed, canceled, etc.
  enum status: { pending: 0, completed: 1, canceled: 2 }

  validates :status, presence: true
end
