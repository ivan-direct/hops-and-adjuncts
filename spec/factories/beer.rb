# frozen_string_literal: true

FactoryBot.define do
  factory :beer do
    sequence(:name) { |n| "Duff#{n}" }
    checkins { 0 }
    rating { 0.0 }
    style { 'other' }

    factory :juicy_bits do
      name { 'Juicy Bits' }
      checkins { 53_700 }
      rating { 4.2 }
      style { 'ipa' }
    end

    factory :steezy do
      name { 'DDH Steezy' }
      checkins { 4_400 }
      rating { 4.26 }
      style { 'ipa' }
    end

    factory :fresh_palette do
      name { 'Fresh Palette' }
      checkins { 1_500 }
      rating { 4.13 }
      style { 'ipa' }
    end

    factory :cosmic_torero do
      name { 'Comic Torero' }
      checkins { 1_900 }
      rating { 4.18 }
      style { 'ipa' }
    end

    factory :perpetual_embrace do
      name { 'Perpetual Embrace' }
      checkins { 372 }
      rating { 4.38 }
      style { 'ipa' }
    end

    factory :electric_moss do
      name { 'Electric Moss' }
      checkins { 542 }
      rating { 4.12 }
      style { 'ipa' }
    end

    factory :a_little_bit_obscure do
      name { 'A Little Bit Obscure' }
      checkins { 187 }
      rating { 4.37 }
      style { 'ipa' }
    end
  end
end
