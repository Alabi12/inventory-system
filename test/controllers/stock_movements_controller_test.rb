require "test_helper"

class StockMovementsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get stock_movements_new_url
    assert_response :success
  end

  test "should get create" do
    get stock_movements_create_url
    assert_response :success
  end

  test "should get index" do
    get stock_movements_index_url
    assert_response :success
  end
end
