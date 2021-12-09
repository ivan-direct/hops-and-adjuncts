# frozen_string_literal: true

json.hop do
  json.id hop.id
  json.name hop.name
  json.rating hop.formatted_rating
  json.ranking hop.ranking
  json.beers do
    json.array! hop.beers_by_rating, partial: 'api/v1/hops/beer', as: :beer
  end
  json.common_pairings hop.common_pairings
  json.delta hop.delta
end
