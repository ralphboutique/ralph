FactoryBot.define do
  factory :role do
    name { "Usuario" }

    trait :admin_role do
      name { "Administrador" }
    end

    trait :seller_role do
      name { "Vendedor" }
    end

    trait :viewer_role do
      name { "Consultor" }
    end

    factory :admin_role, traits: [:admin_role]
    factory :seller_role, traits: [:seller_role]
    factory :viewer_role, traits: [:viewer_role]
  end
end
