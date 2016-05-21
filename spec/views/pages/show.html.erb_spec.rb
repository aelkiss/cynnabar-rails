# frozen_string_literal: true
require 'rails_helper'

describe 'pages/show.html.erb' do
  context 'if the page has a calendar' do
    let(:page) { build(:page, :calendar) }

    before(:each) do
      assign(:page, page)
      render
    end

    subject { rendered }

    it { is_expected.to include(page.calendar_title) }
    it { is_expected.to include(page.events.first['summary']) }
    it { is_expected.to include(page.events.first['location']) }
    # formatted sample date from example.json
    it { is_expected.to include('Wed, Feb  3,  7:00 PM -  9:00 PM') }
  end

  it 'does not show map link if there is no location' do
    page = build(:page, :calendar)
    page.events.each do |e|
      e['location'] = nil
    end
    assign(:page, page)
    render
    expect(rendered).not_to include('maps.google.com')
  end
end
