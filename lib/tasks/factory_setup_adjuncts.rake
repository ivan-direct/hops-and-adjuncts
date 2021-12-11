# frozen_string_literal: true

namespace :factory_setup_adjuncts do
  task build: :environment do
    Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }
    puts 'Building adjuncts...'
    FactoryBot.create(:almond)
    FactoryBot.create(:banana)
    FactoryBot.create(:caramel)
    FactoryBot.create(:cherries)
    FactoryBot.create(:cinnamon)
    FactoryBot.create(:cocoa)
    FactoryBot.create(:coconut)
    FactoryBot.create(:coffee)
    FactoryBot.create(:hazelnut)
    FactoryBot.create(:maple_syrup)
    FactoryBot.create(:marshmallow)
    FactoryBot.create(:peanut_butter)
    FactoryBot.create(:peppers)
    FactoryBot.create(:pistachio)
    FactoryBot.create(:vanilla)
    
    puts 'Complete'
    puts
  end
end
