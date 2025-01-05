require "test_helper"

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  include SignInHelper

  setup do
    @application = applications(:one)
  end

  test "index: if not signed in it should redirect to sign in" do
    get applications_url
    assert_redirected_to new_session_url
  end

  test "index: if signed in it should get index" do
    sign_in_as(users(:one))

    get applications_url
    assert_response :success
  end

  test "show: if not signed in it should redirect to sign in" do
    get application_url(@application)
    assert_redirected_to new_session_url
  end

  test "show: if owner it should show application" do
    sign_in_as(users(:one))

    get application_url(@application)
    assert_response :success
  end

  test "show: if not the owner it should return not found" do
    sign_in_as(users(:two))

    get application_url(@application)
    assert_response :not_found
  end

  test "new: if not signed in it should redirect to sign in" do
    get new_application_url
    assert_redirected_to new_session_url
  end

  test "new: if signed in should get new" do
    sign_in_as(users(:one))

    get new_application_url
    assert_response :success
  end

  test "edit: if not signed in it should redirect to sign in" do
    get edit_application_url(@application)
    assert_redirected_to new_session_url
  end

  test "edit: if owner it should get edit" do
    sign_in_as(users(:one))

    get edit_application_url(@application)
    assert_response :success
  end

  test "edit: if not the owner it should return not found" do
    sign_in_as(users(:two))

    get edit_application_url(@application)
    assert_response :not_found
  end

  test "create: if not signed in it should redirect to sign in" do
    assert_no_difference("Application.count") do
      post applications_url, params: { application: { description: @application.description, name: @application.name, redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
    end

    assert_redirected_to new_session_url
  end

  test "create: if signed in it should create application" do
    sign_in_as(users(:one))

    assert_difference("Application.count") do
      post applications_url, params: { application: { description: @application.description, name: @application.name, redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
    end

    assert_redirected_to application_url(Application.last)
  end

  test "update: if not signed in it should redirect to sign in" do
    patch application_url(@application), params: { application: { description: @application.description, name: @application.name, redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
    assert_redirected_to new_session_url
  end

  test "update: if owner and valid data it should update application" do
    sign_in_as(users(:one))

    patch application_url(@application), params: { application: { description: @application.description, name: @application.name, redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
    assert_redirected_to application_url(@application)
  end

  test "update: if owner and invalid data it should return unprocessable entity" do
    sign_in_as(users(:one))

    patch application_url(@application), params: { application: { description: @application.description, name: "", redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
    assert_response :unprocessable_entity
  end

  test "update: if not the owner it should return not found" do
    sign_in_as(users(:two))

    patch application_url(@application), params: { application: { description: @application.description, name: @application.name, redirect_url: @application.redirect_url, url: @application.url, user_id: @application.user_id } }
    assert_response :not_found
  end

  test "destroy: if not signed in it should redirect to sign in" do
    assert_no_difference("Application.count") do
      delete application_url(@application)
    end

    assert_redirected_to new_session_url
  end

  test "destroy: if owner it should destroy application" do
    sign_in_as(users(:one))

    assert_difference("Application.count", -1) do
      delete application_url(@application)
    end

    assert_redirected_to applications_url
  end

  test "destroy: if not the owner it should return not found" do
    sign_in_as(users(:two))

    assert_no_difference("Application.count") do
      delete application_url(@application)
    end

    assert_response :not_found
  end
end
