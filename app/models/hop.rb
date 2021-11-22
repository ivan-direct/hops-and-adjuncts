# frozen_string_literal: true

class Hop < ApplicationRecord
  has_and_belongs_to_many :beers

  validates :name, presence: true
  validates :name, uniqueness: true
  # Warning: this will return everything until the system matures.
  scope :new_varieties, -> { where('created_at >= ?', Date.today - 6.months).order('created_at desc').limit(10) }

  def total_checkins
    return 0 if beers.blank?

    beers.map(&:checkins).sum
  end

  def formatted_rating
    rating.round(2)
  end

  def find_beers
    # #this will be the calculation for a hops rating #
    rankings = []
    # Hop.all.each do |hop|
    # TODO: hit Untappd API using custom query
    # response = API::GetBeers(hop.name)
    # beers = response.beers.map do |res_beer|
    # TODO: find/create beer record
    # Beer.find_or_create_by(name: res_beer.name)
    # end
    # rating = beers.map(&:rating).sum / beers.size
    # rankings << OpenStruct.new(hop_id: hop.id, rating: rating)
    # end
    ## reverse low high sorting
    # rankings.sort_by!(&:rating).reverse!
    # rankings.each_index do |i|
    #   ranking = rankings[i]
    #   hop = Hop.find(ranking.hop_id)
    #   hop.update(ranking: i + 1) # top rank is one
    # end
  end

  # Utility singleton method use to populate rating and ranking #
  def self.refresh_stats
    rankings = []
    where(rating: nil).find_each do |hop|
      beers = hop.beers
      next if beers.blank?

      rating = beers.map(&:rating).sum / beers.size
      rankings << OpenStruct.new(hop_id: hop.id, rating: rating)
      hop.update(rating: rating)
    end
    rankings.sort_by!(&:rating).reverse!
    rankings.each_index do |i|
      ranking = rankings[i]
      hop = Hop.find(ranking.hop_id)
      hop.update(ranking: i + 1)
    end
  end
end
