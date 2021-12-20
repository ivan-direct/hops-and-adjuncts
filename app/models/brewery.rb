# frozen_string_literal: true

# Beer supplemental class: Brewery Name, City, and State
class Brewery < ApplicationRecord
  has_many :beers, dependent: :nullify

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :city, presence: true
  validates :state, presence: true

  def self.populate_external_codes
    where(external_code: nil).find_each do |brewery|
      brewery.populate_external_code
      sleep 5 unless Rails.env.test? # to avoid hammering their server
    end
  end

  # calls #find_beers for all records containing an external_code
  def self.build_beer_list(style)
    raise 'unknown style' unless %w[ipa stout].include?(style)

    where.not(external_code: nil).find_each do |brewery|
      brewery.find_beers(style)
      sleep 10 unless Rails.env.test? # to avoid hammering their server
    end
  end

  def self.mark_as_invalid(id)
    brewery = where(id: id)
    brewery.update(code_invalid: true) if brewery.present?
  end

  # using Brewery#name query Untappd for exact match # # # # #
  # if found it updates the record # # # # # # # # # # # # # #
  def populate_external_code
    url = "https://untappd.com/search?q=#{name}&type=brewery"
    BreweryFinder.build(url, self)
  end

  # Find the 25 most recent beers for stouts and ipas (other type maybe) # #
  # and create a beer record if a hop name is found in the description # # #
  def find_beers(style)
    type_ids = style == 'ipa' ? BeerFinder::IPA_TYPE_IDS : BeerFinder::STOUT_TYPE_IDS
    type_ids.each do |type_id|
      url = "https://untappd.com/#{external_code}/beer?type_id=#{type_id}&sort=created_at_desc"
      BeerFinder.build(url, id)
      sleep 3 unless Rails.env.test? 
    end
  end
end
