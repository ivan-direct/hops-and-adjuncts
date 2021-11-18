# frozen_string_literal: true

class Hop < ApplicationRecord
  has_and_belongs_to_many :beers

  validates :name, presence: true

  def total_checkins
    return 0 if beers.blank?

    beers.map(&:checkins).sum
  end

  def calculate_ranking
    # this will be the calculation for a hops rating #
    rankings = []
    ## TODO Build hop list. Iterate through #
    Hop.all each do |hop|
      # TODO: hit Untappd API using custom query
      # response = GetBeers(hop.name) ####################################
      response = OpenStruct.new(name: "TODO") # ERASE ME
      # TODO: find/create beer record
      Beer.find_or_create_by(name: response.name)
      # TODO: calc rating
      rating = beers.map(&:rating).sum / beers.size
      rankings << OpenStruct.new(hash_id: hop.id, rating: rating)
    end
    # TODO: sort ratings to get ranking
    rankings.sort_by!(&rating)
    # TODO: and finally, loop through array using the index to insert rankings for each hop
    rankings.each_index do |i|
      ranking = rankings[i]
      hop = Hop.find(ranking.hop_id)
      hop.update(ranking: i + 1) # top rank is one
    end
  end
end
