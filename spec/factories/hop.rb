# frozen_string_literal: true

FactoryBot.define do
  factory :hop do
    sequence(:name) { |n| "Saaz#{n}" }
    description { 'No description available for this hop.' }

    factory :citra do
      name { 'Citra' }
    end

    factory :mosaic do
      name { 'Mosaic' }
    end

    factory :eldorado do
      name { 'El Dorado' }
    end

    factory :nelson_sauvin do
      name { 'Nelson Sauvin' }
    end

    factory :simcoe do
      name { 'Simcoe' }
    end

    factory :galaxy do
      name { 'Galaxy' }
    end

    factory :vic_secret do
      name { 'Vic Secret' }
    end

    factory :columbus do
      name { 'Columbus' }
    end

    factory :strata do
      name { 'Strata' }
    end

    factory :nectaron do
      name { 'Nectaron' }
    end
  end
end
