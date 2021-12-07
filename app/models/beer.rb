# frozen_string_literal: true

# the origin of hop data using Untappd (or other) data feed as the source for all hop stats.
class Beer < ApplicationRecord
  has_and_belongs_to_many :hops
  belongs_to :brewery, optional: true

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :checkins, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than: 5.01 }
  validates :style, inclusion: { in: %w[ipa stout other] }

  def self.calculate_rating(hop)
    beers = select { |beer| beer.hops.include? hop }
    return if beers.blank?

    rating = beers.map(&:rating).sum / beers.size
    hop.update(rating: rating)
    OpenStruct.new(hop_id: hop.id, rating: hop.rating)
  end

  def self.create_ipa(beer_attrs, brewery_id, hops)
    beer = create!(name: beer_attrs[:name], checkins: beer_attrs[:num_ratings], external_id: beer_attrs[:beer_id],
                   brewery_id: brewery_id, style: 'ipa', rating: beer_attrs[:rating])
    beer.hops |= hops
  end
end
