class OauthController < ApplicationController
  AVAILABLE_RESPONSE_TYPES = %w[code token].freeze
  AVAILABLE_GRANT_TYPES = %w[authorization_code].freeze

  skip_before_action :verify_authenticity_token, only: %i[ token ]
  allow_unauthenticated_access only: %i[ token ]
  before_action :validate_response_type, only: %i[ auth ]
  before_action :validate_grant_type, only: %i[ token ]
  before_action :set_application
  before_action :set_user, only: %i[ token ]
  before_action :validate_application

  def auth
    # TODO: For now we assume the user is signed in. Decide how to proceed if not.

    # TODO: token should be invalidated after one use.
    code = Current.user.generate_token_for(:oauth_authentication)

    uri = URI(redirect_uri)
    uri.query = URI.encode_www_form({
      code:,
      state: params[:state]
    })

    redirect_to uri, allow_other_host: true
  end

  def token
    no_store
    # TODO: generate, store and return access_token.

    render json: {
      access_token: "nothing-here-yet",
      token_type: "Bearer",
      expires_in: 3600,
      id_token:
    }
  end

  private

  def set_application
    credential = case action_name
    when "auth"
      OauthApplicationCredential.where(revoked_at: nil).find_by(client_id:)
    when "token"
      OauthApplicationCredential.where(revoked_at: nil).find_by(client_id:, client_secret:)
    else
      nil
    end

    @application = credential&.application
  end

  def set_user
    @user = User.find_by_token_for(:oauth_authentication, params[:code])
  end

  def client_id
    params[:client_id]
  end

  def client_secret
    params[:client_secret]
  end

  def redirect_uri
    params[:redirect_uri]
  end

  def grant_type
    params[:grant_type]
  end

  def validate_response_type
    if !AVAILABLE_RESPONSE_TYPES.include?(params[:response_type])
      render json: {
        error: "invalid response_type"
      }, status: :bad_request and return
    end
  end

  def validate_application
    # TODO: show errors on page, not json.

    if @application.nil?
      render json: {
        error: "invalid client_id"
      }, status: :bad_request and return
    end

    if @application.redirect_url != redirect_uri
      render json: {
        error: "invalid redirect_uri"
      }, status: :bad_request and return
    end
  end

  def validate_grant_type
    if !AVAILABLE_GRANT_TYPES.include?(grant_type)
      render json: {
        error: "invalid grant_type"
      }, status: :bad_request and return
    end
  end

  def id_token
    JWT.encode({
      sub: @user.id,
      email: @user.email_address
    }, client_id, "HS256")
  end
end
