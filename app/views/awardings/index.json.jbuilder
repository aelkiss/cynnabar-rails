json.array!(@awardings) do |awarding|
  json.extract! awarding, :id, :award_id, :recipient_id, :received
  json.url awarding_url(awarding, format: :json)
end
