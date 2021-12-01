# frozen_string_literal: true

namespace :factory_setup do
  task build: :environment do
    raise 'Run rake db:reset before running this task!' if !Hop.count.zero? || !Beer.count.zero?

    Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }
    puts 'Building hops...'
    citra = FactoryBot.create(:citra)
    mosaic = FactoryBot.create(:mosaic)
    eldorado = FactoryBot.create(:eldorado)
    nelson_sauvin = FactoryBot.create(:nelson_sauvin)
    simcoe = FactoryBot.create(:simcoe)
    galaxy = FactoryBot.create(:galaxy)
    columbus = FactoryBot.create(:columbus)
    nectaron = FactoryBot.create(:nectaron)
    vic_secret = FactoryBot.create(:vic_secret)
    strata = FactoryBot.create(:strata)

    puts 'Building breweries...'
    weld_werks = FactoryBot.create(:weld_werks)
    knotted_root = FactoryBot.create(:knotted_root)
    outer_range = FactoryBot.create(:outer_range)

    puts 'Building beers...'
    juicy_bits = FactoryBot.create(:juicy_bits)
    juicy_bits.hops = [citra, mosaic, eldorado]
    juicy_bits.brewery = weld_werks
    juicy_bits.save!
    cosmic_torero = FactoryBot.create(:cosmic_torero)
    cosmic_torero.hops = [galaxy, eldorado]
    cosmic_torero.brewery = weld_werks
    cosmic_torero.save!
    steezy = FactoryBot.create(:steezy)
    steezy.hops = [mosaic, nelson_sauvin]
    steezy.brewery = outer_range
    steezy.save!
    fresh_palette = FactoryBot.create(:fresh_palette)
    fresh_palette.hops = [simcoe, citra, columbus]
    fresh_palette.brewery = outer_range
    fresh_palette.save!
    perpetual_embrace = FactoryBot.create(:perpetual_embrace)
    perpetual_embrace.hops = [nelson_sauvin, vic_secret]
    perpetual_embrace.brewery = knotted_root
    perpetual_embrace.save!
    electric_moss = FactoryBot.create(:electric_moss)
    electric_moss.hops = [citra, strata, simcoe]
    electric_moss.brewery = weld_werks
    electric_moss.save!
    a_little_bit_obscure = FactoryBot.create(:a_little_bit_obscure)
    a_little_bit_obscure.hops = [nectaron]
    a_little_bit_obscure.brewery = knotted_root
    a_little_bit_obscure.save!

    Hop.refresh_stats
    puts 'Complete'
    puts
  end
end
