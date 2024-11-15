require "application_system_test_case"

class PurchaseOrderItemsTest < ApplicationSystemTestCase
  setup do
    @purchase_order_item = purchase_order_items(:one)
  end

  test "visiting the index" do
    visit purchase_order_items_url
    assert_selector "h1", text: "Purchase order items"
  end

  test "should create purchase order item" do
    visit purchase_order_items_url
    click_on "New purchase order item"

    fill_in "Product", with: @purchase_order_item.product_id
    fill_in "Purchase order", with: @purchase_order_item.purchase_order_id
    fill_in "Quantity", with: @purchase_order_item.quantity
    click_on "Create Purchase order item"

    assert_text "Purchase order item was successfully created"
    click_on "Back"
  end

  test "should update Purchase order item" do
    visit purchase_order_item_url(@purchase_order_item)
    click_on "Edit this purchase order item", match: :first

    fill_in "Product", with: @purchase_order_item.product_id
    fill_in "Purchase order", with: @purchase_order_item.purchase_order_id
    fill_in "Quantity", with: @purchase_order_item.quantity
    click_on "Update Purchase order item"

    assert_text "Purchase order item was successfully updated"
    click_on "Back"
  end

  test "should destroy Purchase order item" do
    visit purchase_order_item_url(@purchase_order_item)
    click_on "Destroy this purchase order item", match: :first

    assert_text "Purchase order item was successfully destroyed"
  end
end
