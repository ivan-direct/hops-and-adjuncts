# frozen_string_literal: true

namespace :denver_brewery_setup do
  task build: :environment do
    Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }
    puts 'Building Denver breweries...'
    count = 0
    # source https://www.coloradobrewerylist.com/brewery/
    brewery_names = ['10 Barrel Brewing Company',
                     '14er Brewing Company',
                     'Altitude Brewing & Supply',
                     'Baere Brewing Co',
                     'Banded Oak Brewing Co',
                     'Berkeley Alley Beer Co',
                     'Bierstadt Lagerhaus',
                     'Black Project Spontaneous & Wild Ales',
                     'Black Shirt Brewing Co',
                     'Black Sky Brewery',
                     'Blue Moon Brewing Company',
                     'Blue Tile Brewing',
                     'Briar Common Brewery + Eatery',
                     'Bruz Beers',
                     'Bull & Bush Brewery',
                     'Burns Family Artisan Ales',
                     'Call to Arms Brewing Company',
                     'Cerebral Brewing',
                     'Cerveceria Colorado',
                     'Chain Reaction Brewing',
                     'Cohesion Brewing Company',
                     'Colorado Sake Co.',
                     'Comrade Brewing Co',
                     'Copper Kettle Brewing Company',
                     'Counter Culture Brewery + Grille',
                     'Crooked Stave Artisan Beer Project',
                     'Denver Beer Company',
                     'Denver Chophouse & Brewery',
                     'Diebolt Brewing Company',
                     'Dos Luces',
                     'Epic Brewing Company',
                     'Fiction Beer Company',
                     'FlyteCo Brewing',
                     'Goldspot Brewing Company',
                     "Grandma's House",
                     'Great Divide Brewing Company',
                     'Hogshead Brewery',
                     "J. Moe's Brew Pub",
                     'Jagged Mountain Craft Brewery',
                     'Little Machine',
                     'Long Table Brewhouse',
                     'Lowdown Brewery + Kitchen',
                     'Mockery Brewing',
                     'New Belgium Brewing',
                     'Novel Strand Brewing Company',
                     'Oasis Brewing Company',
                     'Odell Brewing',
                     'Our Mutual Friend Brewing Company',
                     'Pints Pub Brewery & Freehouse',
                     'Platt Park Brewing Company',
                     'Prost Brewing Co. & Biergarten',
                     'Raices Brewing Company',
                     'Ratio Beerworks',
                     'Renegade Brewing Company',
                     'Reverence Brewing',
                     'River North Brewery',
                     'Rock Bottom Restaurant & Brewery',
                     'Seedstock Brewery',
                     'Smash Face Brewing',
                     'So Many Roads Brewery',
                     'Spangalang Brewery',
                     'Station 26 Brewing Co',
                     'Strange Craft Beer Company',
                     'The Empourium Brewing Company',
                     'The Grateful Gnome',
                     'Sandlot Brewery',
                     'Tivoli Brewing Company',
                     'TRVE Brewing Company',
                     'Vine Street Pub & Brewery',
                     'Wah Gwaan Brewing Co',
                     'Woods Boss Brewing',
                     'Wynkoop Brewing Co',
                     'Zuni Street Brewing Co']

    brewery_names.each do |brewery_name|
      count += 1 if Brewery.create(name: brewery_name, city: 'Denver', state: 'CO')
    end
    puts "Created #{count} Denver breweries!"
    puts
  end
end
