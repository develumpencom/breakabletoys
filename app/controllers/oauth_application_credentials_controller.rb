class OauthApplicationCredentialsController < ApplicationController
  before_action :set_application, only: [ :create ]
  before_action :set_oauth_application_credential, only: [ :destroy ]

  def create
    @application.oauth_application_credentials.create!

    redirect_to @application, notice: "Application credentials were successfully created."
  end

  def destroy
    @oauth_application_credential.update!(revoked_at: Time.current)

    redirect_to @oauth_application_credential.application, notice: "Application credentials were successfully revoked."
  end

  private

    def set_application
      @application = Current.user.applications.find(params.expect(:application_id))
    end

    def set_oauth_application_credential
      @oauth_application_credential = Current.user.oauth_application_credentials.find(params.expect(:id))
    end
end
