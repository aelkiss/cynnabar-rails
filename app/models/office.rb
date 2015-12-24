class Office < ActiveRecord::Base
  belongs_to :page
  belongs_to :officer, class_name: 'User'

  validates :email, presence: true
  validates :name, presence: true
  validates :image, presence: true

  def officer_name
    officer ? officer.name : '(Vacant)'
  end
end