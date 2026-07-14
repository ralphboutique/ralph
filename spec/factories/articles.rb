FactoryBot.define do
  factory :article do
    title { "Vestido Elegante" }
    description { "Hermoso vestido para ocasiones especiales" }
    price { 75.50 }
    quantity { 10 }
    status { "active" }
    
    # Asociaciones necesarias
    association :category
    association :warehouse

    # 🎯 FACTORY TRAITS (variaciones)
    trait :out_of_stock do
      quantity { 0 }
    end

    trait :expensive do
      price { 150.0 }
    end

    trait :with_sizes do
      after(:create) do |article|
        sizes = create_list(:size, 3)
        article.sizes = sizes
      end
    end

    trait :with_colors do
      after(:create) do |article|
        create_list(:article_color, 2, article: article)
      end
    end

    # 🏭 FACTORY PARA TESTS ESPECÍFICOS
    factory :expensive_article, traits: [:expensive]
    factory :out_of_stock_article, traits: [:out_of_stock]
    factory :complete_article, traits: [:with_sizes, :with_colors]
  end
end