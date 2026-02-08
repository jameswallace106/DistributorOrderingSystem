require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin_user = users(:admin_user)
  end

  test "should redirect to login when not signed in" do
    get users_url
    assert_redirected_to new_user_session_path
  end

  test "admin can access users index" do
    sign_in @admin_user
    get users_url
    assert_response :success
  end
end
