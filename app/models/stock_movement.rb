class StockMovement < ApplicationRecord
  before_validation :set_default_warehouse
  belongs_to :product

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :movement_type, inclusion: { in: %w(received sold), message: "%{value} is not a valid movement type" }
  # validates :change_quantity, presence: true

  enum change_type: { increase: 0, decrease: 1 }  # or similar

    # Define the received scope
    scope :received, -> { where(movement_type: 'received') }

    # Define the sold scope
    scope :sold, -> { where(movement_type: 'sold')}


    private

    def set_default_warehouse
      self.warehouse_id ||= Warehouse.first&.id
    end
end
