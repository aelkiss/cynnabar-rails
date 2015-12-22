class Page < ActiveRecord::Base
  validates :body, presence: true
  validates :slug, format: { with: /\A[a-z0-9_\/-]+\z/, message: "must contain only lowercase letters, numbers, '_', '-' and '/' characters" }
  validates :slug, format: { with: /\A[a-z0-9].*\z/, message: "must begin with a lowercase letter or a number" }
  validates_uniqueness_of :slug
  validates :title, presence: true

  belongs_to :user

  def to_param
    slug
  end 

  def self.find(input)
    find_by_slug!(input)
  end
end
