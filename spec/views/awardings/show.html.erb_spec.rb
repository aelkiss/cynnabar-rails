# frozen_string_literal: true
require 'rails_helper'

describe 'awardings/show.html.erb' do
  context 'when the awarding has a text with whitespace in it' do
    let(:awarding) { build(:awarding, award_text: "line1\nline2") }

    before(:each) do
      assign(:awarding, awarding)
      render
    end

    it "renders whitespace" do 
      expect(rendered).to include("line1\n<br />line2")
    end 
  end
end
