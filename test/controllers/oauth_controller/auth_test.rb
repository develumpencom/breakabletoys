require "test_helper"

class OauthController::AuthTest < ActionDispatch::IntegrationTest
  include SignInHelper

  # AUTH

  test "redirects to sign in if not signed in" do
    credentials = oauth_application_credentials(:active)

    get oauth_auth_url(response_type: "code", client_id: credentials.client_id, redirect_uri: "invalid", state: "test-state")

    assert_redirected_to new_session_url
  end

  test "returns bad request if invalid redirect_uri" do
    sign_in_as(users(:one))

    credentials = oauth_application_credentials(:active)

    get oauth_auth_url(response_type: "code", client_id: credentials.client_id, redirect_uri: "invalid", state: "test-state")

    assert_response :bad_request
  end

  test "returns bad request if invalid response_type" do
    sign_in_as(users(:one))

    credentials = oauth_application_credentials(:active)

    get oauth_auth_url(response_type: "invalid", client_id: credentials.client_id, redirect_uri: credentials.application.redirect_url, state: "test-state")

    assert_response :bad_request
  end

  test "returns bad request if invalid client_id" do
    sign_in_as(users(:one))

    credentials = oauth_application_credentials(:active)

    get oauth_auth_url(response_type: "code", client_id: "invalid", redirect_uri: credentials.application.redirect_url, state: "test-state")

    assert_response :bad_request
  end

  test "returns bad request if revoked client_id" do
    sign_in_as(users(:one))

    credentials = oauth_application_credentials(:revoked)

    get oauth_auth_url(response_type: "code", client_id: credentials.client_id, redirect_uri: credentials.application.redirect_url, state: "test-state")

    assert_response :bad_request
  end

  test "redirects to redirect_uri with params if valid data" do
    sign_in_as(users(:one))

    credentials = oauth_application_credentials(:active)

    get oauth_auth_url(response_type: "code", client_id: credentials.client_id, redirect_uri: credentials.application.redirect_url, state: "test-state")

    assert_response :redirect
  end
end
