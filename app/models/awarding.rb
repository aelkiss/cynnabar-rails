# frozen_string_literal: true
class Awarding < ApplicationRecord
  belongs_to :award
  belongs_to :recipient
  belongs_to :group

  validates :award, presence: true
  validates :recipient, presence: true

  # group should be present if there is no default group
  validates :group, presence: true, if: proc { |a| a.award.nil? || a.award.group.nil? }

  # award name override should be present iff the award is an 'other award'
  validates :award_name, presence: true, if: proc { |a| a.award.nil? || a.award.other_award? }
  validates :award_name, absence: true, if: proc { |a| a.award && !a.award.other_award? }

  # returns overriden value if present, otherwise falls back to award
  def override_attr(attr, own_attr_val)
    return own_attr_val if own_attr_val
    award.send(attr) if award
  end

  # returns override award name if one exists, otherwise the default group
  def group
    override_attr(:group, super)
  end

  # returns award name or display name (if other award) along with granting group (if not the default)
  def display_name
    override_attr(:name, award_name) + (group == award.group ? '' : " (#{group})")
  end

  def to_s
    display_name
  end

  def received
    return super if super
    '(Unknown)'
  end
end
