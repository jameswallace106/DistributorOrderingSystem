require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should redirect to login when not signed in" do
    get root_url
    assert_redirected_to new_user_session_path
  end

  test "signed in user can access home" do
    sign_in users(:dist_user)
    get root_url
    assert_response :success
  end
end
