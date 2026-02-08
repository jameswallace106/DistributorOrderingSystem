require "test_helper"

class DistributorsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin_user = users(:admin_user)
    @distributor = distributors(:botswana)
  end

  test "should redirect to login when not signed in" do
    get distributors_url
    assert_redirected_to new_user_session_path
  end

  test "admin can access distributors index" do
    sign_in @admin_user
    get distributors_url
    assert_response :success
  end

  test "admin can access new distributor page" do
    sign_in @admin_user
    get new_distributor_url
    assert_response :success
  end

  test "admin can create distributor" do
    sign_in @admin_user

    assert_difference("Distributor.count", 1) do
      post distributors_url, params: { 
        distributor: { 
          name: "New Distributor"
        } 
      }
    end

    assert_redirected_to distributors_url
  end

  test "admin can update distributor" do
    sign_in @admin_user

    patch distributor_url(@distributor), params: { 
      distributor: { 
        name: "Updated Name"
      }
    }

    assert_redirected_to distributors_url
    @distributor.reload
    assert_equal "Updated Name", @distributor.name
  end

  test "cannot create distributor with blank name" do
    sign_in @admin_user

    assert_no_difference('Distributor.count') do
      post distributors_url, params: { 
        distributor: { 
          name: ""
        } 
      }
    end
  end
end