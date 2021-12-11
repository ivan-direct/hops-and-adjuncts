class Adjunct < ApplicationRecord
  include Ingredient

  has_and_belongs_to_many :beers

  validates :name, presence: true
  validates :name, uniqueness: true

  def common_pairings
    sibling_adjuncts = popular_beers.map(&:adjuncts).flatten.uniq - [self]
    sibling_adjuncts.map(&:name).sort
  end

  def update_rating(rating)
    update(rating: rating)
    OpenStruct.new(adjunct_id: id, rating: rating)
  end

  def self.sort_by_ranking(rankings)
    rankings.sort_by!(&:rating).reverse!

    rankings.each_index do |index|
      ranking = rankings[index]
      adjunct = Adjunct.find(ranking.adjunct_id)
      adjunct.update(ranking: index + 1, previous_ranking: adjunct.ranking)
    end
  end

  # Utility singleton method use to populate rating and ranking #
  def self.refresh_stats
    rankings = all.map do |adjunct|
      Beer.calculate_adjunct_rating(adjunct)
    end.compact
    sort_by_ranking(rankings)
  end

  # TODO: implement downcase to increase matches
  # TODO: expand to check Beer name too. example: Coconut Medianoche.
  def self.find_match(description)
    return [] if description.blank?

    adjunct_names = all.pluck(:name)
    matched_names = adjunct_names.select { |name| description.downcase.include?(name) }
    where(name: matched_names)
  end
end
