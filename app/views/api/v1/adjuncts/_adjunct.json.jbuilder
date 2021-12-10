# frozen_string_literal: true

json.adjunct do
  json.id adjunct.id
  json.name adjunct.name
  json.rating adjunct.formatted_rating
  json.ranking adjunct.ranking
  json.beers do
    json.array! adjunct.beers_by_rating, partial: 'api/v1/adjuncts/beer', as: :beer
  end
  json.common_pairings adjunct.common_pairings
  json.delta adjunct.delta
end
