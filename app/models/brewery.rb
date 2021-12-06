# frozen_string_literal: true

require 'open-uri'

# Beer supplemental class: Brewery Name, City, and State
class Brewery < ApplicationRecord
  has_many :beers, dependent: :nullify

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :city, presence: true
  validates :state, presence: true

  def self.populate_external_codes
    brewery_names = where(external_code: nil).pluck(:name)
    no_match = []
    no_link = []
    brewery_names.each do |name|
      url = URI.parse("https://untappd.com/search?q=#{name}&type=brewery")
      response = URI.open(url)
      sleep 5 # to avoid hammering their server
      doc = Nokogiri::HTML(response)

      break unless doc.present?

      element = doc.css('p.total > strong')
      if element.any? && element[0].text == '1 brewery'
        link_element = doc.css('p.name a')
        if link_element.any? && link_element[0].attributes.any? && link_element[0].attributes.has_key?('href')
          # extract external_code from title link
          raw_brewery_code = link_element[0].attributes['href'].value
          brewery_code = raw_brewery_code.gsub('/', '') if raw_brewery_code.present?

          brewery = find_by_name(name)
          brewery.update(external_code: brewery_code)
        end
      else
        no_match << name
      end
    end
    no_match
  end
end
