class OauthController < ApplicationController
  AVAILABLE_RESPONSE_TYPES = %w[code token].freeze

  skip_before_action :verify_authenticity_token, only: %i[ create ]
  allow_unauthenticated_access only: %i[ create ]
  before_action :set_application
  before_action :validate_response_type, only: %i[ show ]
  before_action :validate_application

  def show
    # TODO: For now we assume the user is signed in. Decide how to proceed if not.

    # TODO: token should be invalidated after one use.
    code = Current.user.generate_token_for(:oauth_authentication)

    uri = URI(redirect_uri)
    uri.query = URI.encode_www_form({
      code:,
      state: params[:state],
    })

    redirect_to uri, allow_other_host: true
  end

  def create
    # TODO: veryfy client_id and client_secret, generate and return token.
    render json: {
      access_token: "",
      token_type: "Bearer",
      expires_in: 3600,
      id_token: "JWT with user info"
    }
  end

  private

  def set_application
    @application = OauthApplicationCredential.find_by(client_id:)&.application
  end

  def client_id
    params[:client_id]
  end

  def redirect_uri
    params[:redirect_uri]
  end

  def validate_response_type
    if !AVAILABLE_RESPONSE_TYPES.include?(params[:response_type])
      render json: {
        error: "invalid response_type",
      }, status: :bad_request and return
    end
  end

  def validate_application
    # TODO: show errors on page, not json.

    if @application.nil?
      render json: {
        error: "invalid client_id",
      }, status: :bad_request and return
    end

    if @application.redirect_url != redirect_uri
      render json: {
        error: "invalid redirect_uri",
      }, status: :bad_request and return
    end
  end
end
