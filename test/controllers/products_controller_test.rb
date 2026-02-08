require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin_user = users(:admin_user)
    @product = products(:apple)
  end

  test "should redirect to login when not signed in" do
    get products_url
    assert_redirected_to new_user_session_path
  end

  test "admin can access products index" do
    sign_in @admin_user
    get products_url
    assert_response :success
  end

  test "admin can access new product page" do
    sign_in @admin_user
    get new_product_url
    assert_response :success
  end

  test "admin can create product" do
    sign_in @admin_user

    assert_difference("Product.count", 1) do
      post products_url, params: {
        product: { 
          name: "Mango",
          description: "Tropical fruit"
        }
      }
    end

    assert_redirected_to products_url
  end

  test "admin can update product" do
    sign_in @admin_user

    patch product_url(@product), params: {
      product: { 
        name: "Green Apple",
        description: "Crisp and tart"
      }
    }

    assert_redirected_to products_url
    @product.reload
    assert_equal "Green Apple", @product.name
  end

  test "cannot create product with blank name" do
    sign_in @admin_user

    assert_no_difference("Product.count") do
      post products_url, params: {
        product: {
          name: ""
        }
      }
    end
  end
end
