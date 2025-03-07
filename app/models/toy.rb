class Toy < ApplicationRecord
  enum :status, {
    draft: 0,
    published: 1,
    archived: 2,
    idea: 3
  }

  validates_presence_of :name, :slug, :status

  def to_param
    slug
  end

  def safe_url
    uri = URI.parse(url)

    uri.to_s if uri.is_a?(URI::HTTP)
  rescue URI::InvalidURIError
    nil
  end

  def self.find(slug)
    self.find_by(slug:)
  end
end
