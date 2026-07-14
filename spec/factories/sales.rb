FactoryBot.define do
  factory :sale do
    name { "Juan" }
    lastname { "Pérez" }
    id_number { "12345678" }
    phone { "555-1234" }
    payment_method { "usd" }
    date { Date.current }
    sale_type { "direct" }
    status { "pending" }
    
    # Asociaciones
    association :user

    # Traits para diferentes tipos de venta
    trait :direct_sale do
      sale_type { "direct" }
      status { "approved" }
    end

    trait :credit_sale do
      sale_type { "credit" }
      installments { 3 }
      paid_installments { 0 }
    end

    trait :with_items do
      after(:create) do |sale|
        create_list(:sale_item, 2, sale: sale)
      end
    end

    # Factories específicas
    factory :direct_sale, traits: [:direct_sale]
    factory :credit_sale, traits: [:credit_sale]
    factory :sale_with_items, traits: [:with_items]
  end
end
