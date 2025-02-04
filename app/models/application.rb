class Application < ApplicationRecord
  belongs_to :user
  has_many :oauth_application_credentials, dependent: :destroy

  validates_presence_of :name, :url, :redirect_url
end
