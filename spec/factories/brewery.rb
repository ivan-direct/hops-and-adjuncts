# frozen_string_literal: true

FactoryBot.define do
  factory :brewery do
    sequence(:name) { |n| "Brewery #{n}" }
    city { 'Denver' }
    state { 'CO' }

    factory :weld_werks do
      name { 'WeldWerks' }
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
