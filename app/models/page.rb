class Page < ActiveRecord::Base
  validates :body, presence: true
  validates :slug, format: { with: /\A[a-z0-9_\/-]+\z/, message: "Only lowercase letters, numbers, '_', '-' and '/' characters are allowed in the URL alias" }
  validates :slug, format: { with: /\A[a-z0-9].*\z/, message: "The slug should begin with a lowercase letter or a number." }
  validates_uniqueness_of :slug
  validates :title, presence: true
end
