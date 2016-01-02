class Awarding < ActiveRecord::Base
  belongs_to :award
  belongs_to :recipient
  belongs_to :group

  validates :award, presence: true
  validates :recipient, presence: true

  # group should be present if there is no default group
  validates :group, presence: true, if: Proc.new { |a| a.award.nil? or a.award.group.nil? }

  # award name override should be present iff the award is an 'other award'
  validates :award_name, presence: true, if: Proc.new { |a| a.award.nil? or a.award.other_award? }
  validates :award_name, absence: true, if: Proc.new { |a| a.award and !a.award.other_award? }

  # returns overriden value if present, otherwise falls back to award
  def override_attr(attr,own_attr_val)
    if own_attr_val
      return own_attr_val
    elsif award
      return award.send(attr)
    else
      return nil
    end
  end

  # returns override award name if one exists, otherwise the default group
  def group
    return override_attr(:group,super)
  end

  # returns award name or display name (if other award) along with granting group (if not the default)
  def display_name
    return override_attr(:name,self.award_name) + ( group == award.group ? '' : " (#{group})")
  end

  def to_s
    return display_name
  end

  def received
    if super
      return super
    else
      return "(Unknown)"
    end
  end

end
