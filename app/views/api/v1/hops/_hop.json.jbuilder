json.hop do
  json.id hop.id
  json.name hop.name
  json.rating hop.rating
  json.ranking hop.ranking
  json.beers hop.beers, :id, :name
end
