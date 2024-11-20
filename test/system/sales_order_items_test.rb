require "application_system_test_case"

class SalesOrderItemsTest < ApplicationSystemTestCase
  setup do
    @sales_order_item = sales_order_items(:one)
  end

  test "visiting the index" do
    visit sales_order_items_url
    assert_selector "h1", text: "Sales order items"
  end

  test "should create sales order item" do
    visit sales_order_items_url
    click_on "New sales order item"

    fill_in "Price", with: @sales_order_item.price
    fill_in "Product", with: @sales_order_item.product_id
    fill_in "Quantity", with: @sales_order_item.quantity
    fill_in "Sales order", with: @sales_order_item.sales_order_id
    click_on "Create Sales order item"

    assert_text "Sales order item was successfully created"
    click_on "Back"
  end

  test "should update Sales order item" do
    visit sales_order_item_url(@sales_order_item)
    click_on "Edit this sales order item", match: :first

    fill_in "Price", with: @sales_order_item.price
    fill_in "Product", with: @sales_order_item.product_id
    fill_in "Quantity", with: @sales_order_item.quantity
    fill_in "Sales order", with: @sales_order_item.sales_order_id
    click_on "Update Sales order item"

    assert_text "Sales order item was successfully updated"
    click_on "Back"
  end

  test "should destroy Sales order item" do
    visit sales_order_item_url(@sales_order_item)
    click_on "Destroy this sales order item", match: :first

    assert_text "Sales order item was successfully destroyed"
  end
end
