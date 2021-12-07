require 'open-uri'

module BreweryFinder
  class << self
    # find and create beers for a given url & brewery if they mention a hop name.
    def build(url, brewery)
      response = URI.open(url)
      doc = Nokogiri::HTML(response)

      element = doc.css('p.total > strong')
      if exact_match?(element)
        link_element = doc.css('p.name a')
        brewery_code = extract_attributes(link_element)
        brewery.update(external_code: brewery_code)
      end
    end

    # use nokogiri selectors to extract relevant beer attributes from document
    def extract_attributes(link_element)
      brewery_code = nil
      if link_present?(link_element)
        # extract external_code from title link
        raw_brewery_code = link_element[0].attributes['href'].value
        brewery_code = raw_brewery_code.gsub('/', '') if raw_brewery_code.present?
      end
    end

    # only select queries with a single result
    def exact_match?(element)
      element.any? && element[0].text == '1 brewery'
    end

    def link_present?(link_element)
      link_element.any? && link_element[0].attributes.any? && link_element[0].attributes.has_key?('href')
    end
  end
end
