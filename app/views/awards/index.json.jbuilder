# frozen_string_literal: true
json.array!(@awards) do |award|
  json.extract! award, :id, :name, :description, :precedence
  json.url award_url(award, format: :json)
end
