# frozen_string_literal: true

class Brewery < ApplicationRecord
  has_many :beers, dependent: :nullify
end
