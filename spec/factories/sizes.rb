FactoryBot.define do
  factory :size do
    title { "M" }
    description { "Talla mediana" }

    trait :small do
      title { "S" }
      description { "Talla pequeña" }
    end

    trait :large do
      title { "L" }
      description { "Talla grande" }
    end

    trait :extra_large do
      title { "XL" }
      description { "Talla extra grande" }
    end

    factory :small_size, traits: [:small]
    factory :large_size, traits: [:large]
    factory :xl_size, traits: [:extra_large]
  end
end