class Page < ActiveRecord::Base
  validates :body, presence: true
  validates :slug, format: { with: /\A[a-z0-9_\/-]+\z/, message: "only letters, numbers, '_', '-' and '/' characters are allowed in the URL alias" }
  validates_uniqueness_of :slug
  validates :title, presence: true
end
