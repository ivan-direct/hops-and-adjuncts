# frozen_string_literal: true

require 'open-uri'

# find and create beers for a given url & brewery if they mention a hop name.
module BeerFinder
  # TODO: after we determine free Heroku has enough space... # # # # # # # # #
  # expand to all IPA types. could use a light weigh relational-model for it#
  TYPE_IDS = [284].freeze

  class << self
    def build(url, brewery_id)
      response = URI.parse(url).open
      doc = Nokogiri::HTML(response)

      doc.css('div.beer-item').each do |beer_el|
        hops = match_hops(beer_el)
        create_beer(beer_el, brewery_id, hops) if hops.present?
      end
    end

    def match_hops(beer_el)
      description = beer_el.css('p.desc')[0].text
      hops = Hop.find_match(description)
    end

    # use nokogiri selectors to extract relevant beer attributes from document
    def extract_attributes(beer_el)
      name = beer_el.css('p.name a')[0].text
      rating = beer_el.css('div.caps')[0].attributes['data-rating'].text.to_f
      # might need this to dig down to get checkins
      beer_id = beer_el.attributes['data-bid'].text.to_i
      num_ratings = parse_ratings beer_el
      { name: name, rating: rating, beer_id: beer_id, num_ratings: num_ratings }
    end

    # num checkins with a rating. might want to replace with checkins _see above_
    def parse_ratings(beer_el)
      beer_el.css('div.raters')[0].text.gsub("\n", '').gsub(' Ratings ', '').to_i
    end

    def create_beer(beer_el, brewery_id, hops)
      beer_attrs = extract_attributes(beer_el)
      # TODO: add logic driven by TYPE_ID and create_stout, create_other methods
      Beer.create_ipa(beer_attrs, brewery_id, hops)
    end
  end
end
