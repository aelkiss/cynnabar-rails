class Recipient < ActiveRecord::Base
  include Heraldic

  has_many :awardings
  has_many :awards, through: :awardings
  has_one  :user

  def fix_empty(attr, value)
    value = nil if value && value.match(/^\s*$/)
    write_attribute(attr, value)
  end

  def sca_name=(value)
    fix_empty(:sca_name, value)
  end

  def mundane_name=(value)
    fix_empty(:mundane_name, value)
  end

  def formerly_known_as=(value)
    fix_empty(:formerly_known_as, value)
  end

  def also_known_as=(value)
    fix_empty(:also_known_as, value)
  end

  def heraldry_blazon=(value)
    fix_empty(:heraldry_blazon, value)
  end

  def title=(value)
    fix_empty(:title, value)
  end

  def pronouns=(value)
    fix_empty(:pronouns, value)
  end

  def to_s
    # if both SCA name and mundane name exist, return both. Otherwise, use
    # whichever is populated.
    display_name = ''
    display_inserts = ''

    display_sca_name = ''

    if sca_name
      display_sca_name = sca_name
      display_sca_name = title + ' ' + display_sca_name if title
    end

    if also_known_as && !also_known_as.empty?
      display_inserts += "(also known as #{also_known_as}) "
    end

    if formerly_known_as && !formerly_known_as.empty?
      display_inserts += "(formerly known as #{formerly_known_as}) "
    end

    if is_group
      display_name = "#{sca_name} (Group)"
    elsif sca_name && mundane_name && sca_name != '' && mundane_name != ''
      display_name = "#{display_sca_name} #{display_inserts}(modernly known as #{mundane_name})"
    else
      display_name = (display_sca_name && display_sca_name != '') ? display_sca_name : mundane_name
      display_name += " #{display_inserts}" unless display_inserts.empty?
    end

    display_name
  end

  validates :sca_name, presence: true, if: :is_group
  validates :mundane_name, absence: true, if: :is_group

  validates :sca_name, presence: true, if: 'mundane_name.blank?'
  validates :mundane_name, presence: true, if: 'sca_name.blank?'
end
