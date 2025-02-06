class User < ApplicationRecord
  has_secure_password
  has_many :applications, dependent: :destroy
  has_many :oauth_application_credentials, through: :applications
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  generates_token_for(:oauth_authentication, expires_in: 30.seconds)
end
