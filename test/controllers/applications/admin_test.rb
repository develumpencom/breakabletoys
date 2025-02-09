require "test_helper"

module Applications
  class AdminTest < ActionDispatch::IntegrationTest
    include SignInHelper

    setup do
      @application = applications(:one)
    end

    test "if signed in as admin it should get index" do
      sign_in_as(users(:admin))

      get applications_url
      assert_response :success
    end

    test "if owner, it should show application" do
      sign_in_as(users(:admin))

      get application_url(@application)
      assert_response :success
    end

    test "if not the owner, it should return not found instead of show" do
      sign_in_as(users(:another_admin))

      get application_url(@application)
      assert_response :not_found
    end

    test "if signed in as admin, it should get new" do
      sign_in_as(users(:admin))

      get new_application_url
      assert_response :success
    end

    test "if owner, it should get edit" do
      sign_in_as(users(:admin))

      get edit_application_url(@application)
      assert_response :success
    end

    test "if not the owner, it should return not found instead of edit" do
      sign_in_as(users(:another_admin))

      get edit_application_url(@application)
      assert_response :not_found
    end

    test "if signed in as admin, it should create application" do
      sign_in_as(users(:admin))

      assert_difference("Application.count") do
        post applications_url, params: { application: { description: @application.description, name: @application.name, redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
      end

      assert_redirected_to application_url(Application.last)
    end

    test "if owner and valid data, it should update application" do
      sign_in_as(users(:admin))

      patch application_url(@application), params: { application: { description: @application.description, name: @application.name, redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
      assert_redirected_to application_url(@application)
    end

    test "if owner and invalid data, it should return unprocessable entity" do
      sign_in_as(users(:admin))

      patch application_url(@application), params: { application: { description: @application.description, name: "", redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
      assert_response :unprocessable_entity
    end

    test "if not the owner it should return not found instead of updating the application" do
      sign_in_as(users(:another_admin))

      patch application_url(@application), params: { application: { description: @application.description, name: @application.name, redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
      assert_response :not_found
    end

    test "if owner, it should destroy application" do
      sign_in_as(users(:admin))

      assert_difference("Application.count", -1) do
        delete application_url(@application)
      end

      assert_redirected_to applications_url
    end

    test "if not the owner, it should return not found instead of destroying the application" do
      sign_in_as(users(:another_admin))

      assert_no_difference("Application.count") do
        delete application_url(@application)
      end

      assert_response :not_found
    end
  end
end
