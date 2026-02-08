require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @distributor_user = users(:dist_user)
    @admin_user = users(:admin_user)
    @order = orders(:in_progress_order)
  end

  test "should redirect to login when not signed in" do
    get orders_url
    assert_redirected_to new_user_session_path
  end

  test "distributor user can access orders index" do
    sign_in @distributor_user
    get orders_url
    assert_response :success
  end

  test "admin user can access orders index" do
    sign_in @admin_user
    get orders_url
    assert_response :success
  end

  test "distributor can create new order" do
    sign_in @distributor_user
    get new_order_url
    assert_response :success
  end

  test "distributor can configure their in-progress order" do
    sign_in @distributor_user
    get configure_order_url(@order)
    assert_response :success
  end
end