FactoryBot.define do
  factory :category do
    title { "Vestidos" }
    description { "Elegantes vestidos para toda ocasión" }

    # Variaciones de categorías
    trait :dresses do
      title { "Vestidos" }
    end

    trait :shoes do
      title { "Zapatos" }
      description { "Calzado de alta calidad" }
    end

    trait :accessories do
      title { "Accesorios" }
      description { "Complementos perfectos" }
    end

    # Factories con traits
    factory :dress_category, traits: [:dresses]
    factory :shoe_category, traits: [:shoes] 
    factory :accessory_category, traits: [:accessories]
  end
end