# frozen_string_literal: true
class Group < ActiveRecord::Base
  validates :name, presence: true

  def to_s
    name
  end
end
