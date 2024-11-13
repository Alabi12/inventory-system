require "test_helper"

class StockAdjustmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock_adjustment = stock_adjustments(:one)
  end

  test "should get index" do
    get stock_adjustments_url
    assert_response :success
  end

  test "should get new" do
    get new_stock_adjustment_url
    assert_response :success
  end

  test "should create stock_adjustment" do
    assert_difference("StockAdjustment.count") do
      post stock_adjustments_url, params: { stock_adjustment: { adjustment_type: @stock_adjustment.adjustment_type, product_id: @stock_adjustment.product_id, quantity: @stock_adjustment.quantity } }
    end

    assert_redirected_to stock_adjustment_url(StockAdjustment.last)
  end

  test "should show stock_adjustment" do
    get stock_adjustment_url(@stock_adjustment)
    assert_response :success
  end

  test "should get edit" do
    get edit_stock_adjustment_url(@stock_adjustment)
    assert_response :success
  end

  test "should update stock_adjustment" do
    patch stock_adjustment_url(@stock_adjustment), params: { stock_adjustment: { adjustment_type: @stock_adjustment.adjustment_type, product_id: @stock_adjustment.product_id, quantity: @stock_adjustment.quantity } }
    assert_redirected_to stock_adjustment_url(@stock_adjustment)
  end

  test "should destroy stock_adjustment" do
    assert_difference("StockAdjustment.count", -1) do
      delete stock_adjustment_url(@stock_adjustment)
    end

    assert_redirected_to stock_adjustments_url
  end
end
