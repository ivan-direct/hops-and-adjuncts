# frozen_string_literal: true

json.hop do
  json.id hop.id
  json.name hop.name
  json.rating hop.formatted_rating
  json.ranking hop.ranking
  json.beers hop.beers, :id, :name, :rating, :checkins, :style
  json.common_pairings hop.common_pairings
  json.delta hop.delta
end
