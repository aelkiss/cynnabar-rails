class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [ :admin, :normal ]
  after_initialize :set_defaults

  def set_defaults
    self.role ||= :normal
  end
end
