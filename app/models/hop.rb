# frozen_string_literal: true

class Hop < ApplicationRecord
  has_and_belongs_to_many :beers

  validates :name, presence: true

  def total_checkins
    return 0 if beers.blank?
    beers.map(&:checkins).sum
  end
end
