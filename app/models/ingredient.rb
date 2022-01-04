# frozen_string_literal: true

# shared methods between Hops and Adjuncts
module Ingredient
  def total_checkins
    return 0 if beers.blank?

    beers.map(&:checkins).sum
  end

  def formatted_rating
    return nil if rating.blank?

    rating.round(2)
  end

  # top 10 based on number of checkins
  def popular_beers
    beers.order(checkins: :desc).limit(5)
  end

  # change in ranking (1 is highest rank) #
  def delta
    previous_ranking - ranking
  rescue StandardError
    0
  end

  def beers_by_rating
    beers.order(rating: :desc)
  end

  module ClassMethods
    def search(query)
      if query.present?
        where('rating > ? and LOWER(name) like ?', 0, '%'+query.downcase+'%').order(rating: :desc)
      else
        where('rating > ?', 0).order(rating: :desc)
      end
    end

    # calulate the deltas and return the three highest ranking risers
    def popular
      records = where('ranking is not null and previous_ranking is not null').sort_by do |record|
        record.previous_ranking - record.ranking
      end.reverse # sorting low-high for some reason
      records.size >= 3 ? records[0..2] : records
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end
end
