require "test_helper"

module Applications
  class UserTest < ActionDispatch::IntegrationTest
    include SignInHelper

    setup do
      @application = applications(:one)
    end

    test "if signed in as user, index should redirect to root and show an alert" do
      sign_in_as(users(:one))

      get applications_url
      assert_redirected_to root_url
      assert_equal "You are not authorized to access this page.", flash[:alert]
    end

    test "if signed in as user, show should redirect to sign in" do
      sign_in_as(users(:one))

      get application_url(@application)

      assert_redirected_to root_url
      assert_equal "You are not authorized to access this page.", flash[:alert]
    end

    test "if signed in as user, new should redirect to sign in" do
      sign_in_as(users(:one))

      get new_application_url

      assert_redirected_to root_url
      assert_equal "You are not authorized to access this page.", flash[:alert]
    end

    test "if signed in as user, edit should redirect to sign in" do
      sign_in_as(users(:one))

      get edit_application_url(@application)

      assert_redirected_to root_url
      assert_equal "You are not authorized to access this page.", flash[:alert]
    end

    test "if signed in as user, create should redirect to sign in" do
      sign_in_as(users(:one))

      assert_no_difference("Application.count") do
        post applications_url, params: { application: { description: @application.description, name: @application.name, redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
      end

      assert_redirected_to root_url
      assert_equal "You are not authorized to access this page.", flash[:alert]
    end

    test "if signed in as user, update should redirect to sign in" do
      sign_in_as(users(:one))

      patch application_url(@application), params: { application: { description: @application.description, name: @application.name, redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }

      assert_redirected_to root_url
      assert_equal "You are not authorized to access this page.", flash[:alert]
    end

    test "if signed in as user, destroy should redirect to sign in" do
      sign_in_as(users(:one))

      assert_no_difference("Application.count") do
        delete application_url(@application)
      end

      assert_redirected_to root_url
      assert_equal "You are not authorized to access this page.", flash[:alert]
    end
  end
end
