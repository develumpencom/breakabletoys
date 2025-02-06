require "test_helper"

class OauthController::TokenTest < ActionDispatch::IntegrationTest
  include SignInHelper

  # TOKEN

  test "returns bad request if invalid client_id" do
    credentials = oauth_application_credentials(:active)
    user = credentials.application.user

    params = {
      grant_type: "authorization_code",
      code: user.generate_token_for(:oauth_authentication),
      redirect_uri: credentials.application.redirect_url,
      client_id: "invalid",
      client_secret: credentials.client_secret
    }

    post oauth_token_url, params: params

    assert_response :bad_request
  end

  test "returns bad request if invalid redirect_url" do
    credentials = oauth_application_credentials(:active)
    user = credentials.application.user

    params = {
      grant_type: "authorization_code",
      code: user.generate_token_for(:oauth_authentication),
      redirect_uri: "invalid",
      client_id: credentials.client_id,
      client_secret: credentials.client_secret
    }

    post oauth_token_url, params: params

    assert_response :bad_request
  end

  test "returns bad request if invalid grant type" do
    credentials = oauth_application_credentials(:active)
    user = credentials.application.user

    params = {
      grant_type: "invalid",
      code: user.generate_token_for(:oauth_authentication),
      redirect_uri: credentials.application.redirect_url,
      client_id: credentials.client_id,
      client_secret: credentials.client_secret
    }

    post oauth_token_url, params: params

    assert_response :bad_request
  end

  test "returns ok if valid data" do
    credentials = oauth_application_credentials(:active)
    user = credentials.application.user

    params = {
      grant_type: "authorization_code",
      code: user.generate_token_for(:oauth_authentication),
      redirect_uri: credentials.application.redirect_url,
      client_id: credentials.client_id,
      client_secret: credentials.client_secret
    }

    post oauth_token_url, params: params

    assert_response :ok
  end
end
