FactoryBot.define do
  factory :beer do
    name { 'Duff' }
    checkins { 0 }
    rating { 0.0 }
    style { 'other' }
  end
end
