require "test_helper"

class Users::AccountControllerTest < ActionDispatch::IntegrationTest
  include SignInHelper

  test "show: if not signed in it should redirect to sign in" do
    get account_url

    assert_redirected_to new_session_url
  end

  test "show: if signed in it should get show" do
    sign_in_as(users(:one))

    get account_url
    assert_response :success
  end
end
