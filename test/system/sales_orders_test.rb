require "application_system_test_case"

class SalesOrdersTest < ApplicationSystemTestCase
  setup do
    @sales_order = sales_orders(:one)
  end

  test "visiting the index" do
    visit sales_orders_url
    assert_selector "h1", text: "Sales orders"
  end

  test "should create sales order" do
    visit sales_orders_url
    click_on "New sales order"

    fill_in "Customer", with: @sales_order.customer_id
    fill_in "Delivery time", with: @sales_order.delivery_time
    fill_in "Order date", with: @sales_order.order_date
    fill_in "Received date", with: @sales_order.received_date
    fill_in "Status", with: @sales_order.status
    fill_in "Supplier", with: @sales_order.supplier_id
    fill_in "Total amount", with: @sales_order.total_amount
    click_on "Create Sales order"

    assert_text "Sales order was successfully created"
    click_on "Back"
  end

  test "should update Sales order" do
    visit sales_order_url(@sales_order)
    click_on "Edit this sales order", match: :first

    fill_in "Customer", with: @sales_order.customer_id
    fill_in "Delivery time", with: @sales_order.delivery_time
    fill_in "Order date", with: @sales_order.order_date
    fill_in "Received date", with: @sales_order.received_date
    fill_in "Status", with: @sales_order.status
    fill_in "Supplier", with: @sales_order.supplier_id
    fill_in "Total amount", with: @sales_order.total_amount
    click_on "Update Sales order"

    assert_text "Sales order was successfully updated"
    click_on "Back"
  end

  test "should destroy Sales order" do
    visit sales_order_url(@sales_order)
    click_on "Destroy this sales order", match: :first

    assert_text "Sales order was successfully destroyed"
  end
end
