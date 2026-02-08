require "test_helper"

class StockKeepingUnitsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin_user = users(:admin_user)
    @sku = stock_keeping_units(:sku_one)
    @product = products(:banana)
    @distributor = distributors(:china)
  end

  test "should redirect to login when not signed in" do
    get stock_keeping_units_url
    assert_redirected_to new_user_session_path
  end

  test "admin can access skus index" do
    sign_in @admin_user
    get stock_keeping_units_url
    assert_response :success
  end

  test "admin can access new sku page" do
    sign_in @admin_user
    get new_stock_keeping_unit_url
    assert_response :success
  end

  test "admin can create sku" do
    sign_in @admin_user

    assert_difference("StockKeepingUnit.count", 1) do
      post stock_keeping_units_url, params: { 
        stock_keeping_unit: {
          price: 5.99,
          product_id: @product.id,
          distributor_id: @distributor.id
        }
      }
    end

    assert_redirected_to stock_keeping_units_url
  end

  test "admin can access edit sku page" do
    sign_in @admin_user
    get configure_stock_keeping_unit_url(@sku)
    assert_response :success
  end

  test "admin can update sku" do
    sign_in @admin_user

    patch stock_keeping_unit_url(@sku), params: {
      stock_keeping_unit: {
        price: 3.50
      }
    }

    assert_redirected_to stock_keeping_units_url
    @sku.reload
    assert_equal 3.50, @sku.price
  end

  test "cannot create sku without price" do
    sign_in @admin_user

    assert_no_difference("StockKeepingUnit.count") do
      post stock_keeping_units_url, params: {
        stock_keeping_unit: {
          price: nil,
          product_id: @product.id,
          distributor_id: @distributor.id
        }
      }
    end
  end

  test "cannot create sku without product" do
    sign_in @admin_user

    assert_no_difference("StockKeepingUnit.count") do
      post stock_keeping_units_url, params: {
        stock_keeping_unit: {
          price: 5.99,
          product_id: nil,
          distributor_id: @distributor.id
        }
      }
    end
  end

  test "cannot create sku without distributor" do
    sign_in @admin_user

    assert_no_difference("StockKeepingUnit.count") do
      post stock_keeping_units_url, params: {
        stock_keeping_unit: {
          price: 5.99,
          product_id: @product.id,
          distributor_id: nil
        } 
      }
    end
  end
end
