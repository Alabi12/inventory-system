class WarehousesController < ApplicationController
  def index
    @warehouses = Warehouse.all
  end
end
