require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  include SignInHelper

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "with valid incredentials should redirect to new_session_url and render an alert" do
    post session_url, params: { email_address: "fake@example.com", password: "p4ssw0rd" }

    assert_redirected_to new_session_url
    assert_nil cookies[:session_id]
    assert_equal "Try another email address or password.", flash[:alert]
  end

  test "with valid credentials should create a signed cookie and redirect to root_url" do
    assert cookies[:session_id].blank?

    assert_difference("Session.count") do
      post session_url, params: { email_address: "one@example.com", password: "password" }
    end

    assert_redirected_to root_url
    assert_not cookies[:session_id].blank?
  end

  test "should delete session and redirect to new_session_url" do
    sign_in_as(users(:one))

    assert_not cookies[:session_id].blank?

    assert_difference("Session.count", -1) do
      delete session_url
    end

    assert_redirected_to root_url
    assert cookies[:session_id].blank?
  end
end
