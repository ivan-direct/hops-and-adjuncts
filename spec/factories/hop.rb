FactoryBot.define do
  factory :hop do
    sequence(:name) { |n| "Saaz#{n}" }
  end
end
