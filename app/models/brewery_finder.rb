# frozen_string_literal: true

require 'open-uri'

# find and create beers for a given url & brewery if they mention a hop name.
module BreweryFinder
  class << self
    def build(url, brewery)
      response = URI.parse(url).open
      doc = Nokogiri::HTML(response)

      element = doc.css('p.total > strong')
      return unless exact_match?(element)

      link_element = doc.css('p.name a')
      brewery_code = extract_attributes(link_element)
      brewery.update(external_code: brewery_code)
    end

    # use nokogiri selectors to extract relevant beer attributes from document
    def extract_attributes(link_element)
      return unless link_present?(link_element)

      # extract external_code from title link
      raw_brewery_code = link_element[0].attributes['href'].value
      raw_brewery_code.gsub('/', '') if raw_brewery_code.present?
    end

    # only select queries with a single result
    def exact_match?(element)
      element.any? && element[0].text == '1 brewery'
    end

    def link_present?(link_element)
      link_element.any? && link_element[0].attributes.any? && link_element[0].attributes.key?('href')
    end
  end
end
