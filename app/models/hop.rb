# frozen_string_literal: true

class Hop < ApplicationRecord
  has_and_belongs_to_many :beers
end
