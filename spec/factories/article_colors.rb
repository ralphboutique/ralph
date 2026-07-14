FactoryBot.define do
  factory :article_color do
    title { "Rojo" }
    color_code { "#FF0000" }
    
    # Asociación
    association :article

    trait :blue do
      title { "Azul" }
      color_code { "#0000FF" }
    end

    trait :black do
      title { "Negro" }  
      color_code { "#000000" }
    end

    trait :white do
      title { "Blanco" }
      color_code { "#FFFFFF" }
    end

    factory :blue_color, traits: [:blue]
    factory :black_color, traits: [:black]
    factory :white_color, traits: [:white]
  end
end