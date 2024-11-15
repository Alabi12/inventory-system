require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get inventory" do
    get reports_inventory_url
    assert_response :success
  end

  test "should get reorder_points" do
    get reports_reorder_points_url
    assert_response :success
  end

  test "should get stock_movements" do
    get reports_stock_movements_url
    assert_response :success
  end

  test "should get sales" do
    get reports_sales_url
    assert_response :success
  end
end
