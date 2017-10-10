# frozen_string_literal: true
class Recipient < ApplicationRecord
  include Heraldic

  has_many :awardings
  has_many :awards, through: :awardings
  has_one  :user

  def fix_empty(attr, value)
    value = nil if value && value.match(/^\s*$/)
    self[attr] = value
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

    if is_group
      "#{sca_name} (Group)"
    elsif both_names?
      "#{format_sca_name} #{format_inserts}(modernly known as #{mundane_name})"
    else
      format_one_name
    end
  end

  validates :sca_name, presence: true, if: :is_group
  validates :mundane_name, absence: true, if: :is_group

  validates :sca_name, presence: true, if: 'mundane_name.blank?'
  validates :mundane_name, presence: true, if: 'sca_name.blank?'

  private

  def both_names?
    sca_name && mundane_name && sca_name != '' && mundane_name != ''
  end

  def format_one_name
    display_name = if format_sca_name&.empty?
                     mundane_name
                   else
                     format_sca_name
                   end

    if format_inserts.empty?
      display_name
    else
      "#{display_name} #{format_inserts}"
    end
  end

  def format_sca_name
    if sca_name && title
      title + ' ' + sca_name
    elsif sca_name
      sca_name
    else
      ''
    end
  end

  def format_inserts
    display_inserts = ''

    if also_known_as && !also_known_as.empty?
      display_inserts += "(also known as #{also_known_as}) "
    end

    if formerly_known_as && !formerly_known_as.empty?
      display_inserts += "(formerly known as #{formerly_known_as}) "
    end

    display_inserts
  end
end
