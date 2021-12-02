# frozen_string_literal: true

json.id beer.id
json.name beer.name
json.rating beer.rating
json.checkins beer.checkins
json.style beer.style
if beer.brewery
  json.brewery beer.brewery, :id, :name, :city, :state
else
  json.brewery do
    json.id nil
    json.name nil
    json.city nil
    json.state nil
  end
end
