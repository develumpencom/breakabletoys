class OauthApplicationCredential < ApplicationRecord
  belongs_to :application

  has_secure_token :client_id, length: 32
  has_secure_token :client_secret, length: 64

  def revoked?
    revoked_at.present?
  end
end
