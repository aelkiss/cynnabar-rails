class Award < ActiveRecord::Base
  include Heraldic 

  has_many :awardings
  has_many :recipients, through: :awardings
  belongs_to :group

  validates :name, presence: true

  validates :description, presence: true,
    length: { minimum: 30 }

  validates :precedence, presence: true

  has_many :awardings
  has_many :awards, through: :awardings

  def to_s
    name
  end

  private

end
