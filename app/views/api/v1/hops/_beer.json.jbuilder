# frozen_string_literal: true

json.id beer.id
json.name beer.name
json.checkins beer.checkins
json.style beer.style
json.brewery beer.brewery, :id, :name, :city, :state if beer.brewery
