FactoryBot.define do
  factory :warehouse do
    title { "Almacén Principal" }
    description { "Almacén central de la tienda" }

    trait :secondary do
      title { "Almacén Secundario" }
      description { "Almacén de respaldo" }
    end

    trait :online do
      title { "Almacén Online" }
      description { "Almacén para ventas online" }
    end

    factory :secondary_warehouse, traits: [:secondary]
    factory :online_warehouse, traits: [:online]
  end
end