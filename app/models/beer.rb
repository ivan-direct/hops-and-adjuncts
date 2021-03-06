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
    # exclude new beers that do not having a rating
    beers = where('checkins > ? or rating > ?', 0, 0.0).select { |beer| beer.hops.include? hop }
    return if beers.blank?

    rating = Beer.calc_rating(beers)
    hop.update_rating(rating) if rating > 0 # skip if weighting would make rating negative
  end

  def self.calculate_adjunct_rating(adjunct)
    # exclude new beers that do not having a rating
    beers = where('checkins > ? and rating > ?', 0, 0.0).select { |beer| beer.adjuncts.include? adjunct }
    return if beers.blank?

    rating = Beer.calc_rating(beers)
    adjunct.update_rating(rating) if rating > 0 # skip if weighting would make rating negative
  end

  def self.weighted_rating(beers)
    case beers.size
    when 0..3
      1.0
    when 4..10
      0.5
    when 11..23
      0.25
    when 24..48
      0.1
    else
      0.0
    end
  end

  def self.calc_rating(beers)
    rating = beers.map(&:rating).sum / beers.size
    # penalize adjuncts with few beers to avoid elevating fringe adjuncts
    rating -= Beer.weighted_rating(beers)
  end

  # update or create a new ipa style beer
  def self.create_ipa(beer_attrs, brewery_id, hops)
    beer = Beer.create_beer(beer_attrs, brewery_id, hops, 'ipa')
    beer.hops |= hops
  end

  # update or create a new stout style beer
  def self.create_stout(beer_attrs, brewery_id, adjuncts)
    beer = Beer.create_beer(beer_attrs, brewery_id, adjuncts, 'stout')
    beer.adjuncts |= adjuncts
  end

  def self.create_beer(beer_attrs, brewery_id, _hops, type)
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
    beer
  end
end
