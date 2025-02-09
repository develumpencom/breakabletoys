require "test_helper"

module Applications
  class GuestTest < ActionDispatch::IntegrationTest
    include SignInHelper

    setup do
      @application = applications(:one)
    end

    test "if not signed in, index should redirect to sign in" do
      get applications_url
      assert_redirected_to new_session_url
    end

    test "if not signed in, show should redirect to sign in" do
      get application_url(@application)
      assert_redirected_to new_session_url
    end

    test "if not signed in, new should redirect to sign in" do
      get new_application_url
      assert_redirected_to new_session_url
    end

    test "if not signed in, edit should redirect to sign in" do
      get edit_application_url(@application)
      assert_redirected_to new_session_url
    end

    test "if not signed in, create should redirect to sign in" do
      assert_no_difference("Application.count") do
        post applications_url, params: { application: { description: @application.description, name: @application.name, redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
      end

      assert_redirected_to new_session_url
    end

    test "if not signed in, update should redirect to sign in" do
      patch application_url(@application), params: { application: { description: @application.description, name: @application.name, redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
      assert_redirected_to new_session_url
    end

    test "if not signed in, destroy should redirect to sign in" do
      assert_no_difference("Application.count") do
        delete application_url(@application)
      end

      assert_redirected_to new_session_url
    end
  end
end
