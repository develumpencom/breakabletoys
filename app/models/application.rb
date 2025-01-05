class Application < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :url, :redirect_url
end
