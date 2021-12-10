# frozen_string_literal: true

# the origin of hop data using Untappd (or other) data feed as the source for all hop stats.
class Beer < ApplicationRecord
  has_and_belongs_to_many :hops
  has_and_belongs_to_many :adjuncts
  belongs_to :brewery, optional: true

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :checkins, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than: 5.01 }
  validates :style, inclusion: { in: %w[ipa stout other] }

  # @return struct(hop_id: id, rating: rating) or nil
  def self.calculate_hop_rating(hop)
    beers = select { |beer| beer.hops.include? hop }
    return if beers.blank?

    rating = beers.map(&:rating).sum / beers.size
    hop.update_rating(rating)
  end

  def self.calculate_adjunct_rating(adjunct)
    beers = select { |beer| beer.adjuncts.include? adjunct }
    return if beers.blank?

    rating = beers.map(&:rating).sum / beers.size
    adjunct.update_rating(rating)
  end

  # update or create a new ipa style beer
  def self.create_ipa(beer_attrs, brewery_id, hops)
    Beer.create_beer(beer_attrs, brewery_id, hops, 'ipa')
  end

  # update or create a new stout style beer
  def self.create_stout(beer_attrs, brewery_id, adjuncts)
    Beer.create_beer(beer_attrs, brewery_id, adjuncts, 'stout')
  end

  def self.create_beer(beer_attrs, brewery_id, hops, type)
    beer_name = beer_attrs[:name]
    checkins = beer_attrs[:num_ratings]
    rating = beer_attrs[:rating]

    if exists?(name: beer_name)
      beer = Beer.find_by_name(beer_name)
      beer.update(checkins: checkins, rating: rating)
    else
      beer = create!(name: beer_name, checkins: checkins, external_id: beer_attrs[:beer_id],
                     brewery_id: brewery_id, style: type, rating: rating)
    end
    beer.hops |= hops
  end
end
