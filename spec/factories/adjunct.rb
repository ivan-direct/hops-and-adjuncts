FactoryBot.define do
  factory :adjunct do
    sequence(:name) { |n| "Chocolate #{n}" }

    factory :almond do
      name { 'almond' }
    end

    factory :banana do
      name { 'banana' }
    end

    factory :caramel do
      name { 'caramel' }
    end

    factory :cherries do
      name { 'cherries' }
    end

    factory :cinnamon do
      name { 'cinnamon' }
    end

    factory :cocoa do
      name { 'cocoa' }
    end

    factory :coconut do
      name { 'coconut' }
    end

    factory :coffee do
      name { 'coffee' }
    end

    factory :hazelnut do
      name { 'hazelnut' }
    end

    factory :maple_syrup do
      name { 'maple syrup' }
    end

    factory :marshmallow do
      name { 'marshmallow' }
    end

    factory :peanut_butter do
      name { 'peanut butter' }
    end

    factory :peppers do
      name { 'peppers' }
    end

    factory :pistachio do
      name { 'pistachio' }
    end

    factory :vanilla do
      name { 'vanilla' }
    end
  end
end
