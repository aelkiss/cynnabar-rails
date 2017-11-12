# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable
  validates :name, presence: true
  validates :approved, inclusion: { in: [true, false] }
  belongs_to :recipient
  validates :recipient_id, uniqueness: true, allow_nil: true

  enum role: [:admin, :normal, :herald]
  after_initialize :set_defaults

  def set_defaults
    self.role ||= :normal
    self.approved ||= false
  end

  def to_s
    name
  end
end
