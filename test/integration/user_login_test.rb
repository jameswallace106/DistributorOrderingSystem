# test/integration/user_login_test.rb
require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  test "should display login page" do
    get new_user_session_path
    assert_response :success
    assert_select "form"
  end

  test "admin user can login with correct password" do
    post user_session_path, params: {
      user: {
        username: "ADMIN",
        password: "Beans"
      }
    }
    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end

  test "distributor user can login with correct password" do
    post user_session_path, params: {
      user: {
        username: "DIST",
        password: "Beans"
      }
    }
    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end

  test "cannot login with wrong password" do
    post user_session_path, params: {
      user: {
        username: "ADMIN",
        password: "WrongPassword"
      }
    }
    # Expect 422 in Rails 8 for invalid submissions
    assert_response :unprocessable_entity
  end

  test "cannot login with non-existent username" do
    post user_session_path, params: {
      user: {
        username: "NONEXISTENT",
        password: "Beans"
      }
    }
    assert_response :unprocessable_entity
  end

  test "cannot login with blank username" do
    post user_session_path, params: {
      user: {
        username: "",
        password: "Beans"
      }
    }
    assert_response :unprocessable_entity
  end

  test "cannot login with blank password" do
    post user_session_path, params: {
      user: {
        username: "ADMIN",
        password: ""
      }
    }
    assert_response :unprocessable_entity
  end

  test "admin user has admin privileges" do
    admin = users(:admin_user)
    assert admin.is_admin?
    assert_not_nil admin.admin
  end

  test "distributor user does not have admin privileges" do
    dist = users(:dist_user)
    assert_not dist.is_admin?
    assert_not_nil dist.distributor
  end

  test "user can logout after logging in" do
    # Use Devise test helper
    sign_in users(:admin_user)
    
    get root_path
    assert_response :success

    # Logout
    delete destroy_user_session_path
    assert_redirected_to root_path
    
    # Try to access protected page
    get orders_path
    assert_redirected_to new_user_session_path
  end

  test "unauthenticated user cannot access orders page" do
    get orders_path
    assert_redirected_to new_user_session_path
  end
end