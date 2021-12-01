# frozen_string_literal: true

class Brewery < ApplicationRecord
  has_many :beers, dependent: :nullify

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :city, presence: true
  validates :state, presence: true
end
