# frozen_string_literal: true
require 'json'

class Page < ActiveRecord::Base
  validates :body, presence: true
  validates :slug, format: { with: %r{\A[a-z0-9_/-]+\z}, message: "must contain only lowercase letters, numbers, '_', '-' and '/' characters" }
  validates :slug, format: { with: /\A[a-z0-9].*\z/, message: 'must begin with a lowercase letter or a number' }
  validates :slug, uniqueness: true
  validates :title, presence: true
  validates :user, presence: true
  validates :calendar_title, presence: true, if: :calendar

  belongs_to :user
  has_one :office

  def to_param
    slug
  end

  def self.find(input)
    find_by_slug!(input)
  end

  def events
    load_calendar_if_needed
    @events['events'] if @events
  end

  def calendar_link
    load_calendar_if_needed
    @events['link'] if @events
  end

  def format_event_date(event)
    Time.zone.parse(event['start']).strftime('%a, %b %e')
  end

  def format_event_time(event)
    start_time = Time.zone.parse(event['start'])
    end_time = Time.zone.parse(event['end'])
    if start_time.to_date == end_time.to_date
      "#{format_time(start_time)} - #{format_time(end_time)}"
    else
      "#{format_time(start_time)} - #{end_time.strftime('%b %e')} #{format_time(end_time)}"
    end
  end

  private

  def format_time(datetime)
    datetime.strftime('%l:%M %p')
  end

  def load_calendar_if_needed
    if calendar && !@events
      begin
        @events = JSON.load(Rails.root.join('config', 'calendar', "#{calendar}.json"))
      # ignore problems -- you just don't get a calendar.
      rescue IOError, SystemCallError, JSON::ParserError => e
        logger.warn(e.to_s)
      end
    end
  end
end
