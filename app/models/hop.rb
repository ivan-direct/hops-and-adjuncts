# frozen_string_literal: true

# Store Hop data derived manually and through APIs and/or webscraping #
# Used by: /api/v1/hops endpoints # # # # # # # # # # # # # # # # # # #
class Hop < ApplicationRecord
  include Ingredient

  has_and_belongs_to_many :beers

  validates :name, presence: true
  validates :name, uniqueness: true
  # Warning: this will return everything until the system matures.
  scope :new_varieties, -> { where('created_at >= ?', Time.zone.today - 6.months).order('created_at desc').limit(10) }

  def common_pairings
    sibling_hops = popular_beers.map(&:hops).flatten.uniq - [self]
    sibling_hops.map(&:name).sort
  end

  def update_rating(rating)
    update(rating: rating)
    OpenStruct.new(hop_id: id, rating: rating)
  end

  def self.sort_by_ranking(rankings)
    rankings.sort_by!(&:rating).reverse!

    rankings.each_index do |index|
      ranking = rankings[index]
      hop = Hop.find(ranking.hop_id)
      hop.update(ranking: index + 1, previous_ranking: hop.ranking)
    end
  end

  # # calulate the deltas and return the three highest ranking risers
  # def self.popular
  #   hops = where('ranking is not null and previous_ranking is not null').sort_by do |hop|
  #     hop.previous_ranking - hop.ranking
  #   end.reverse # sorting low-high for some reason
  #   hops.size >= 3 ? hops[0..2] : hops
  # end

  # Utility singleton method use to populate rating and ranking #
  def self.refresh_stats
    rankings = all.map do |hop|
      Beer.calculate_rating(hop)
    end.compact
    sort_by_ranking(rankings)
  end

  # TODO: implement downcase to increase matches
  # TODO: expand to check Beer name too. example: DDH Citra Juicy Bits.
  def self.find_match(description)
    return [] if description.blank?

    hop_names = all.pluck(:name)
    matched_names = hop_names.select { |name| description.include?(name) }
    where(name: matched_names)
  end
end
