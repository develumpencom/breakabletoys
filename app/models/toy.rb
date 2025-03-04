class Toy < ApplicationRecord
  enum :status, {
    draft: 0,
    published: 1,
    archived: 2,
    idea: 3
  }

  validates_presence_of :name, :slug, :status
end
