class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable
  validates :name, presence: true
  validates :approved, inclusion: { in: [true, false] }
  belongs_to :recipient

  enum role: [ :admin, :normal, :herald ]
  after_initialize :set_defaults

  def set_defaults
    self.role ||= :normal
    self.approved ||= false
  end

  def to_s
    name
  end
end
