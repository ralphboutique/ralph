FactoryBot.define do
  factory :sale_item do
    quantity { 2 }
    price { 25.50 }
    
    # Asociaciones
    association :sale
    association :article

    trait :large_quantity do
      quantity { 5 }
    end

    trait :expensive_item do
      price { 75.00 }
    end

    factory :expensive_sale_item, traits: [:expensive_item]
    factory :bulk_sale_item, traits: [:large_quantity]
  end
end
