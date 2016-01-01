class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable

  enum role: [ :admin, :normal, :herald ]
  after_initialize :set_defaults

  def set_defaults
    self.role ||= :normal
  end
end
