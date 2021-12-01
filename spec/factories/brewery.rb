# frozen_string_literal: true

FactoryBot.define do
  factory :brewery do
    sequence(:name) { |n| "Brewery #{n}" }
    state { 'CO' }

    factory :weld_werks do
      name { 'Weld Werks' }
      city { 'Greeley' }
    end

    factory :knotted_root do
      name { 'Knotted Root' }
      city { 'Nederland' }
    end

    factory :outer_range do
      name { 'Outer Range' }
      city { 'Frisco' }
    end
  end
end
