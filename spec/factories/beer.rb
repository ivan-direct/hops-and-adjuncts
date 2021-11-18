FactoryBot.define do
  factory :beer do
    sequence(:name) { |n| "Duff#{n}" }
    checkins { 0 }
    rating { 0.0 }
    style { 'other' }
  end
end
