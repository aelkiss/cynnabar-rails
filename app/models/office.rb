class Office < ActiveRecord::Base
  belongs_to :page
  belongs_to :officer, class_name: 'User'

  validates :email, presence: true
  validates :name, presence: true
  validates :image, presence: true
  validates :page, presence: true

  def officer_name
    officer ? officer.name : '(Vacant)'
  end

  def to_s
    "#{name}, #{officer_name}"
  end
end
