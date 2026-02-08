require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @distributor_user = users(:dist_user)
    @order = orders(:in_progress_order)
    @sku = stock_keeping_units(:sku_one)
  end

  test "should redirect to login when not signed in" do
    post order_items_url(@order), params: { 
      stock_keeping_unit_id: @sku.id, 
      quantity: 1 
    }
    assert_redirected_to new_user_session_path
  end

  test "distributor can add item to their order" do
    sign_in @distributor_user

    assert_difference("Item.count", 1) do
      post order_items_url(@order), params: { 
        stock_keeping_unit_id: @sku.id, 
        quantity: 2 
      }
    end

    assert_response :redirect
  end

  test "distributor can delete item from their order" do
    sign_in @distributor_user
    item = items(:item_four)

    assert_difference("Item.count", -1) do
      delete item_url(item)
    end
  end
end