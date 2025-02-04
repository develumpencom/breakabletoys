require "test_helper"

class OauthApplicationCredentialsControllerTest < ActionDispatch::IntegrationTest
  include SignInHelper

  setup do
    @application = applications(:one)
    @oauth_application_credential = oauth_application_credentials(:active)
  end

  test "create: if not signed in it should redirect to sign in" do
    assert_no_difference("OauthApplicationCredential.count") do
      post application_oauth_application_credentials_url(@application)
    end

    assert_redirected_to new_session_url
  end

  test "create: if signed in it should create oauth application credential" do
    sign_in_as(@application.user)

    assert_difference("OauthApplicationCredential.count") do
      post application_oauth_application_credentials_url(@application)
    end

    assert_redirected_to @application
    assert_equal "Application credentials were successfully created.", flash[:notice]
  end

  test "destroy: if not signed in it should redirect to sign in" do
    assert_no_difference("OauthApplicationCredential.count") do
      delete oauth_application_credential_url(@application)
    end

    assert_redirected_to new_session_url
  end

  test "destroy: if owner it should revoke oauth application credential" do
    sign_in_as(@application.user)

    assert_not @oauth_application_credential.revoked_at.present?

    delete oauth_application_credential_url(@oauth_application_credential)

      assert_redirected_to @oauth_application_credential.application

    @oauth_application_credential.reload

    assert @oauth_application_credential.revoked_at.present?
  end

  test "destroy: if not the owner it should return not found" do
    sign_in_as(users(:two))

    delete oauth_application_credential_url(@application)

    assert_response :not_found
  end
end
