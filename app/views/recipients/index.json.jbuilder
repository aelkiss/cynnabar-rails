json.array!(@recipients) do |recipient|
  json.extract! recipient, :id, :sca_name, :mundane_name, :is_group
  json.url recipient_url(recipient, format: :json)
end
